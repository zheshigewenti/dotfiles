# dotfiles

```
sudo timedatectl set-ntp true #时间同步

sudo pacman -Syyu
sudo pacman -S stow
sudo pacman -S zsh
su root
sudo chsh -s /bin/zsh <username> #username平替用户名

sudo pacman -S git github-cli
gh auth login #注意保存github令牌

## stow管理
cd dotfiles
git config --global user.name "vincent" #记录当前提交者

#ln nvim到你的.config文件夹中
stow zsh
stow nvim


##打开nvim :LAZY更新  :MASON安装补全引擎


## 安装yay
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si"

##安装字体
#英文
yay -S ttf-liberation
#中文&韩文
yay -S wqy-microhei-kr-patched
#字符&表情
yay -S ttf-sourcecodepro-nerd noto-fonts-emoji
```
