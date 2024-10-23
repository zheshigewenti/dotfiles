# tips

```shell
#软件 cfdisk iwd stow fd ctags ripgrep tmux

## iwd
#wifi
iwctl
device list
station <waln> scan
staion <wlan> get-networks
station <wlan> connect <wifi-ssid>
#dhcp
cd /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true
#dhcpcd
dhcpcd &

sudo passwd root
cd /etc/
vim pacman.conf #进入pacman配置文件

[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch #清华源
pacman-key --lsign-key "farseerfc@archlinux.org" #本地信任farseerfc的GPG key

sudo timedatectl set-ntp true #时间同步

sudo pacman -Syyu

sudo pacman -S stow
sudo pacman -S zsh
sudo pacman -S neovim #记得checkhealth
su root
sudo chsh -s /bin/zsh vincent #改变vincent的shell

sudo pacman -S git github-cli
gh auth login #注意保存github令牌

##stow管理
cd dotfiles
git config --global user.name "vincent" #告知git用户为vincent

#ln nvim到你的.config文件夹中
stow zsh
stow nvim
stow -D #取消相关软链接

##打开nvim :LAZY更新  :MASON安装补全引擎

##安装yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si"

<space>gcc #neovim快速标注

##tmux
#使用tpm管理插件
prefix键设置为C-z
prefix-\ 左右分终端
prefix-- 上下分终端
prefix-d 分离当前终端
prefix-s 打开终端列表
prefix-x 关闭当前终端
tmux a    #重新连接最近会话
tmux a -t #重新连接托管会话
tmux new -s #创建新会话会话


##安装字体
#英文
yay -S ttf-liberation
#中文&韩文
yay -S wqy-microhei-kr-patched
#字符&表情
yay -S ttf-sourcecodepro-nerd noto-fonts-emoji
```
