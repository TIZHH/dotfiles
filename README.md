# CachyOS dotfiles

这个仓库只用于通过 GitHub 保存 CachyOS 桌面和开发环境配置。它不自动部署配置，也不创建软链接；备份和恢复都使用普通的 `cp` 命令。

## 保存的内容

- `hypr/.config/hypr/`：Hyprland、Hyprlock 和 Hyprpaper
- `waybar/.config/waybar/`：Waybar 配置和样式
- `wofi/.config/wofi/`：Wofi 配置和样式
- `kitty/.config/kitty/`：Kitty 配置
- `zsh/`：默认的 CachyOS Zsh、Oh My Zsh 和 Powerlevel10k 配置
- `variants/zsh/zshrc.no-oh-my-zsh`：不使用 Oh My Zsh 的备用配置
- `wallpapers/Pictures/papers/`：桌面和锁屏壁纸
- `packages/*.txt`：需要安装的软件包清单

## 安装软件包

脚本只读取 `packages/*.txt`，去掉注释和重复项，然后通过 `pacman` 安装缺少的软件：

```bash
./install-packages.sh
```

它不会复制配置、覆盖文件或启用系统服务。

网络和蓝牙服务可按需手动启用：

```bash
sudo systemctl enable --now NetworkManager bluetooth
```

## 备份当前配置

在仓库根目录执行：

```bash
mkdir -p hypr/.config/hypr waybar/.config/waybar
mkdir -p wofi/.config/wofi kitty/.config/kitty
mkdir -p wallpapers/Pictures/papers

cp -a ~/.config/hypr/. hypr/.config/hypr/
cp -a ~/.config/waybar/. waybar/.config/waybar/
cp -a ~/.config/wofi/. wofi/.config/wofi/
cp -a ~/.config/kitty/. kitty/.config/kitty/
cp -a ~/Pictures/papers/pexels-splitshire-1562.jpg wallpapers/Pictures/papers/
```

确认 `~/.zshrc` 不含令牌、密码等敏感信息后，再备份 Zsh：

```bash
cp -a ~/.zshrc zsh/.zshrc
cp -a ~/.p10k.zsh zsh/.p10k.zsh
```

不要提交 `~/.zshrc.secrets`、SSH 私钥、API Token、Wi-Fi 密码或其他凭据。

检查并推送：

```bash
git status
git diff
git add .
git commit -m "Update dotfiles"
git push
```

## 在新系统恢复

克隆仓库并安装软件：

```bash
git clone git@github.com:TIZHH/dotfiles.git ~/Workspace/dotfiles
cd ~/Workspace/dotfiles
./install-packages.sh
```

复制桌面配置和壁纸：

```bash
mkdir -p ~/.config/hypr ~/.config/waybar ~/.config/wofi ~/.config/kitty
mkdir -p ~/Pictures/papers

cp -a hypr/.config/hypr/. ~/.config/hypr/
cp -a waybar/.config/waybar/. ~/.config/waybar/
cp -a wofi/.config/wofi/. ~/.config/wofi/
cp -a kitty/.config/kitty/. ~/.config/kitty/
cp -a wallpapers/Pictures/papers/. ~/Pictures/papers/
```

复制默认 Zsh 配置：

```bash
cp -a zsh/.zshrc ~/
cp -a zsh/.p10k.zsh ~/
cp -a zsh/.zshrc.secrets.example ~/.zshrc.secrets
chmod 600 ~/.zshrc.secrets
```

编辑 `~/.zshrc.secrets` 填入本机需要的凭据。若不想使用 Oh My Zsh，可以改用备用版本：

```bash
cp -a variants/zsh/zshrc.no-oh-my-zsh ~/.zshrc
```

完成后重新登录桌面会话，或者按需重启相关程序。

## 机器相关设置

换机器后需要检查：

- `hyprland.lua` 中的显示器名称、位置和缩放比例
- `hyprpaper.conf` 中的显示器名称
- Waybar 中的 `intel_backlight` 设备名称
- Zsh 中的个人项目路径
