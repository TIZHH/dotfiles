# CachyOS dotfiles

用于在重装 CachyOS 后恢复当前的 Hyprland 桌面环境。配置由 GNU Stow 管理，仓库中的文件会链接到主目录，因此日常修改 `~/.config` 下的配置也会直接反映到本仓库。

## 当前包含

- Hyprland：显示器、环境变量、动画、窗口规则与快捷键
- Hyprlock 与 Hyprpaper
- Waybar
- Wofi
- Kitty
- CachyOS Zsh、Oh My Zsh、Powerlevel10k、fzf 与常用补全/高亮插件
- 当前桌面和锁屏使用的壁纸
- Hyprland 环境所需的软件包清单

## 新系统恢复

```bash
git clone git@github.com:TIZHH/dotfiles.git ~/Workspace/dotfiles
cd ~/Workspace/dotfiles
./bootstrap.sh --install
```

如果软件已经安装，只创建配置链接：

```bash
./bootstrap.sh
```

脚本不会覆盖主目录中已有的普通文件。如果 Stow 报告冲突，请先备份对应配置，再重新执行脚本。

网络和蓝牙服务可在新系统中按需启用：

```bash
sudo systemctl enable --now NetworkManager bluetooth
```

## 日常同步

这些目录现在由仓库管理：

```text
~/.config/hypr
~/.config/waybar
~/.config/wofi
~/.config/kitty
~/.zshrc
~/Pictures/papers/pexels-splitshire-1562.jpg
```

`bootstrap.sh` 默认部署 `zsh/.zshrc`，使用 CachyOS 提供的 Oh My Zsh、
fzf 和 Powerlevel10k 配置。个人代理、AI/Codex 和项目路径也保留在该文件中。

不使用 Oh My Zsh 的旧配置保存在
`variants/zsh/zshrc.no-oh-my-zsh`，仅用于参考或手动切换，不会被恢复脚本部署。
Powerlevel10k 的外观配置保存在 `zsh/.p10k.zsh`。

令牌和 Wi-Fi 密码不应进入 Git。首次恢复后创建私密配置：

```bash
cp ~/.zshrc.secrets.example ~/.zshrc.secrets
chmod 600 ~/.zshrc.secrets
```

然后填写 `~/.zshrc.secrets`。`.zshrc` 会自动加载该文件，但不会打印令牌内容。

修改配置后正常使用 Git 提交即可：

```bash
git status
git add .
git commit -m "Update desktop config"
git push
```

## 机器相关设置

以下内容仍与当前硬件有关，换机器后可能需要修改：

- `eDP-1` 与 `HDMI-A-1` 显示器名称
- 笔记本屏幕缩放比例 `1.67`
- Waybar 使用的 `intel_backlight` 背光设备
