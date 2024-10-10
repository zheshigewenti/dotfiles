# dotfiles&config

```
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
sudo pacman -S neovim #记得checkhealt
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

##打开nvim :LAZY更新  :MASON安装补全引擎

##安装yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si"

<space>gcc #快速标注

##安装字体
#英文
yay -S ttf-liberation
#中文&韩文
yay -S wqy-microhei-kr-patched
#字符&表情
yay -S ttf-sourcecodepro-nerd noto-fonts-emoji
```
