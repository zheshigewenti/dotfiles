import Carbon
import Foundation

// MARK: - TIS helpers

func allSources() -> [TISInputSource] {
    let props = [kTISPropertyInputSourceCategory: kTISCategoryKeyboardInputSource] as CFDictionary
    guard let arr = TISCreateInputSourceList(props, false)?.takeRetainedValue() as? [TISInputSource] else { return [] }
    return arr
}

func strProp(_ s: TISInputSource, _ key: CFString) -> String? {
    guard let p = TISGetInputSourceProperty(s, key) else { return nil }
    return Unmanaged<CFString>.fromOpaque(p).takeUnretainedValue() as String
}

func id(_ s: TISInputSource) -> String { strProp(s, kTISPropertyInputSourceID) ?? "" }
func name(_ s: TISInputSource) -> String { strProp(s, kTISPropertyLocalizedName) ?? "" }

func isSelectable(_ s: TISInputSource) -> Bool {
    guard let p = TISGetInputSourceProperty(s, kTISPropertyInputSourceIsSelectCapable) else { return true }
    let n = Unmanaged<CFBoolean>.fromOpaque(p).takeUnretainedValue()
    return CFBooleanGetValue(n)
}

func currentID() -> String {
    guard let c = TISCopyCurrentKeyboardInputSource()?.takeRetainedValue() else { return "" }
    return id(c)
}

// macOS 26+ CJK 切换有竞态，选完等一会再退出（macism 3.1.1 的修复点）
func settle(_ ms: UInt32 = 150) { usleep(ms * 1000) }

func switchTo(_ s: TISInputSource) -> Bool {
    guard TISSelectInputSource(s) == noErr else { return false }
    // 切到中文输入法时多等一会（CJK 有竞态）；切英文很快，少等以缩短 shell 启动时间
    settle(isChinese(s) ? 150 : 30)
    return true
}

func isEnglish(_ sid: String) -> Bool { sid.hasPrefix("com.apple.keylayout.") }
func isChinese(_ s: TISInputSource) -> Bool {
    let n = name(s).lowercased()
    return n.contains("pinyin") || n.contains("拼音") || n.contains("chinese") || n.contains("简体") || n.contains("双拼")
}

func englishSource(_ list: [TISInputSource]) -> TISInputSource? {
    if let us = list.first(where: { id($0) == "com.apple.keylayout.US" }) { return us }
    if let abc = list.first(where: { id($0) == "com.apple.keylayout.ABC" }) { return abc }
    return list.first(where: { isEnglish(id($0)) })
}

func chineseSource(_ list: [TISInputSource]) -> TISInputSource? {
    let cn = list.filter { isChinese($0) && isSelectable($0) }
    // 优先真正的输入法（带子输入源），而不是 "Chinese, Simplified" 这种父项
    return cn.first(where: { id($0).contains("ITABC") }) ?? cn.first(where: { id($0).hasPrefix("com.apple.inputmethod") })
}

// MARK: - CLI

let args = CommandLine.arguments.dropFirst().map { $0.lowercased() }
let list = allSources().filter { isSelectable($0) && !id($0).isEmpty }
let cmd = args.first ?? "get"

func printList() {
    let cur = currentID()
    for s in list {
        let mark = id(s) == cur ? "*" : " "
        print("\(mark) \(id(s))\t\(name(s))")
    }
}

func fail(_ msg: String) -> Never {
    FileHandle.standardError.write((msg + "\n").data(using: .utf8)!)
    exit(1)
}

switch cmd {
case "get", "":
    print(currentID())

case "list", "ls":
    printList()

case "toggle", "t":
    if isEnglish(currentID()) {
        guard let cn = chineseSource(list) else { fail("no Chinese input source enabled") }
        if !switchTo(cn) { fail("switch failed") }
    } else {
        guard let en = englishSource(list) else { fail("no English input source enabled") }
        if !switchTo(en) { fail("switch failed") }
    }
    print(currentID())

case "en", "english", "us":
    guard let en = englishSource(list) else { fail("no English input source enabled") }
    if !switchTo(en) { fail("switch failed") }
    print(currentID())

case "zh", "cn", "chinese", "pinyin":
    guard let cn = chineseSource(list) else { fail("no Chinese input source enabled") }
    if !switchTo(cn) { fail("switch failed") }
    print(currentID())

default:
    let want = args.joined(separator: " ")
    // 1) 精确 id  2) id 前缀  3) 名称包含
    if let s = list.first(where: { id($0).lowercased() == want })
        ?? list.first(where: { id($0).lowercased().hasPrefix(want) })
        ?? list.first(where: { name($0).lowercased().contains(want) }) {
        if !switchTo(s) { fail("switch failed") }
        print(currentID())
    } else {
        fail("no input source matches: \(want)\nrun: im list")
    }
}
