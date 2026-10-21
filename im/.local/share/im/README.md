# im

macOS 输入法切换，单文件 Swift，无第三方依赖（替代 brew 的 macism）。

```sh
im            # 当前输入源 id
im list       # 列出可切换的输入源（* 为当前）
im en         # 英文
im zh         # 中文（拼音）
im toggle     # 中英互切
im u.s.       # 按名字模糊匹配
```

安装：

```sh
stow -d ~/dotfiles -t ~ im              # 链接源码到 ~/.local/share/im
make -C ~/.local/share/im install       # 编译到 ~/.local/bin/im
```

改了 `im.swift` 之后重新 `make -C ~/.local/share/im install` 即可。
二进制不进 git，避免 arm64 产物跟着仓库走。
