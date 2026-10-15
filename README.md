# CachyOS dotfiles

这个仓库通过 GitHub 保存 CachyOS 的桌面和 Shell 配置，并使用 GNU Stow 在主目录建立链接。

## 保存的内容

- `hypr/.config/hypr/`：Hyprland、Hyprlock 和 Hyprpaper
- `waybar/.config/waybar/`：Waybar 配置和样式
- `wofi/.config/wofi/`：Wofi 配置和样式
- `kitty/.config/kitty/`：Kitty 配置
- `zsh/`：CachyOS Zsh、Oh My Zsh 和 Powerlevel10k
- `variants/zsh/zshrc.no-oh-my-zsh`：不使用 Oh My Zsh 的备用配置
- `wallpapers/Pictures/papers/`：桌面和锁屏壁纸
- `packages/*.txt`：软件包清单

快捷键和鼠标操作见 [`KEYBINDINGS.md`](KEYBINDINGS.md)。

## 新系统恢复

```bash
git clone git@github.com:TIZHH/dotfiles.git ~/Workspace/dotfiles
cd ~/Workspace/dotfiles
./install-packages.sh
./link-dotfiles.sh
```

`install-packages.sh` 只读取 `packages/*.txt`，去重后通过 `pacman` 安装缺少的软件。

`link-dotfiles.sh` 会先列出所有目标，然后逐项处理：

1. 目标不存在：直接建立 Stow 链接。
2. 已经是当前仓库链接：保持不变。
3. 目标文件或目录已存在：先在原路径旁创建带时间戳的 `.backup-*` 备份，再建立链接。
4. 某一项链接失败：恢复该项刚刚移动的备份并停止。

脚本处理以下目标：

```text
~/.config/hypr
~/.config/waybar
~/.config/wofi
~/.config/kitty
~/Pictures/papers/pexels-splitshire-1562.jpg
~/.zshrc
~/.p10k.zsh
~/.zshrc.secrets.example
```

真实的 `~/.zshrc.secrets` 不会被链接、备份或覆盖。

网络和蓝牙服务可按需手动启用：

```bash
sudo systemctl enable --now NetworkManager bluetooth
```

## 更新仓库中的配置

链接完成后，修改上述配置就是直接修改仓库文件。检查后提交：

```bash
cd ~/Workspace/dotfiles
git status
git diff
git add .
git commit -m "Update dotfiles"
git push
```

不要提交 `~/.zshrc.secrets`、SSH 私钥、API Token、Wi-Fi 密码或其他凭据。

## 不使用 Oh My Zsh

备用配置保存在：

```text
variants/zsh/zshrc.no-oh-my-zsh
```

需要时可以手动复制：

```bash
mv ~/.zshrc ~/.zshrc.oh-my-zsh
cp -a variants/zsh/zshrc.no-oh-my-zsh ~/.zshrc
```

## 机器相关设置

换机器后需要检查：

- `hyprland.lua` 中的显示器名称、位置和缩放比例
- `hyprpaper.conf` 中的显示器名称
- Waybar 中的 `intel_backlight` 设备名称
- Zsh 中的个人项目路径
