# tips

```shell
##iwd
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

##wsl
wsl.exe --shutdown
wsl --unregister arch #注销该子系统，这才是完全卸载

#disk&wifiutils cfdisk iwd

timedatectl set-ntp true
cfdisk
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi/
swapon /dev/sda2
pacstrap /mnt base linux linux-firmware sudo grub efibootmgr networkmanager intel-ucode neovim
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
nvim /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf 
systemctl enable NetworkManager
useradd -m -G wheel vincent
passwd

#archutils stow fd ctags ripgrep tmux unzip npm joshuto lazygit yay feh nmap wget openssh neovim

sudo passwd root
su root
cd /etc/
vim pacman.conf #进入pacman配置源
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
sudo pacman-key --lsign-key "farseerfc@archlinux.org" #本地信任farseerfc的GPG key
sudo pacman-key --lsign-key "lilac@build.archlinuxcn.org"  #本地信任lilac的GPG key                        
sudo pacman -S zsh
sudo chsh -s /bin/zsh vincent #改变vincent的shell #重启wsl后开代理
sudo pacman -Syyu
sudo pacman -S stow fd ctags ripgrep tmux unzip npm joshuto lazygit yay feh nmap wget openssh neovim github-cli git

##git
git clone https://github.com/zheshigewenti/dotfiles.git
gh auth login #github-cli登录 注意保存github token
cd dotfiles
git config --global user.name "vincent" #告知git用户为vincent

##stow
C-d 向下翻页
C-u 向上翻页
stow zsh
stow nvim #nvim lazy和mason记得更新
stow -D #取消相关软链接

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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/bin/install_plugins #tpm安装

##latex
sudo pacman -S texlive-core texlive-langchinese

##fonts
yay -S ttf-liberation #英文
yay -S wqy-microhei-kr-patched #中文&韩文
yay -S ttf-sourcecodepro-nerd noto-fonts-emoji #字符&表情

gc<space> #neovim快速标注
sudo timedatectl set-ntp true #时间同步
```
