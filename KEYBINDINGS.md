# 快捷键速查

本文档汇总仓库中**明确配置**的快捷键和鼠标操作。Hyprland 以
[`hyprland.lua`](hypr/.config/hypr/hyprland.lua) 为准；
[`hyprland-copy.conf`](hypr/.config/hypr/hyprland-copy.conf) 仅作为旧配置的回退参考，不纳入下表。

## 按键约定

- `Alt` 是 Hyprland 的主修饰键（`mainMod`）。
- `Shift`、`Ctrl` 分别表示 Shift 和 Control。
- `方向键` 表示 `←`、`↓`、`↑`、`→`。
- `鼠标左键` / `鼠标右键` 对应 Hyprland 的 `mouse:272` / `mouse:273`。
- 音量、亮度和媒体键可以在锁屏状态下使用；音量和亮度键支持按住连续调整。

## Hyprland

配置来源：[`hypr/.config/hypr/hyprland.lua`](hypr/.config/hypr/hyprland.lua)

### 应用与会话

| 快捷键 | 动作 |
| --- | --- |
| `Alt + Enter` | 打开 Kitty 终端 |
| `Alt + E` | 打开 Dolphin 文件管理器 |
| `Alt + D` | 打开 Wofi 应用启动器 |
| `Alt + ;` | 锁定屏幕（Hyprlock） |
| `Alt + Shift + R` | 启动 `hyprshutdown`；若命令不可用则退出 Hyprland |

### 窗口与布局

| 快捷键 | 动作 |
| --- | --- |
| `Alt + P` | 切换当前窗口的伪平铺状态 |
| `Alt + T` | 切换 Dwindle 分割方向 |
| `Alt + Shift + T` | 交换当前 Dwindle 分割的两侧 |
| `Alt + F` | 切换当前窗口全屏 |
| `Alt + Shift + F` | 切换当前窗口浮动状态 |
| `Alt + Shift + Q` | 关闭当前窗口 |

### 焦点、交换与尺寸

| 快捷键 | 动作 |
| --- | --- |
| `Alt + H` / `Alt + ←` | 焦点移到左侧窗口 |
| `Alt + J` / `Alt + ↓` | 焦点移到下方窗口 |
| `Alt + K` / `Alt + ↑` | 焦点移到上方窗口 |
| `Alt + L` / `Alt + →` | 焦点移到右侧窗口 |
| `Alt + Shift + H` | 当前窗口与左侧窗口交换 |
| `Alt + Shift + J` | 当前窗口与下方窗口交换 |
| `Alt + Shift + K` | 当前窗口与上方窗口交换 |
| `Alt + Shift + L` | 当前窗口与右侧窗口交换 |
| `Alt + Ctrl + H` | 当前窗口宽度减少 40 px |
| `Alt + Ctrl + J` | 当前窗口高度增加 40 px |
| `Alt + Ctrl + K` | 当前窗口高度减少 40 px |
| `Alt + Ctrl + L` | 当前窗口宽度增加 40 px |

四个尺寸调整快捷键均支持按住连续触发。

### 截图

| 快捷键 | 动作 |
| --- | --- |
| `Alt + Shift + A` | 框选区域并复制截图到剪贴板 |
| `Alt + Shift + S` | 框选区域并在 Swappy 中编辑 |

### 工作区

| 快捷键 | 动作 |
| --- | --- |
| `Alt + 1` … `Alt + 9` | 切换到工作区 1–9 |
| `Alt + 0` | 切换到工作区 10 |
| `Alt + Shift + 1` … `Alt + Shift + 9` | 将当前窗口移到工作区 1–9 |
| `Alt + Shift + 0` | 将当前窗口移到工作区 10 |
| `Alt + X` | 显示或隐藏 `magic` 特殊工作区 |
| `Alt + Shift + X` | 将当前窗口移到 `magic` 特殊工作区 |

### 鼠标与触控板

| 操作 | 动作 |
| --- | --- |
| `Alt + 滚轮向下` | 切换到前一个现有工作区（`e-1`） |
| `Alt + 滚轮向上` | 切换到后一个现有工作区（`e+1`） |
| `Alt + 拖动鼠标左键` | 移动窗口 |
| `Alt + 拖动鼠标右键` | 调整窗口尺寸 |
| 三指水平滑动 | 切换工作区 |

### 音量、亮度与媒体

| 按键 | 动作 |
| --- | --- |
| `音量增加` | 默认输出设备音量增加 5%，最高 100% |
| `音量降低` | 默认输出设备音量降低 5% |
| `静音` | 切换默认输出设备静音状态 |
| `麦克风静音` | 切换默认输入设备静音状态 |
| `亮度增加` | 屏幕亮度增加 5% |
| `亮度降低` | 屏幕亮度降低 5% |
| `下一曲` | 播放下一曲 |
| `播放/暂停` | 切换播放和暂停 |
| `上一曲` | 播放上一曲 |

## Kitty

配置来源：[`kitty/.config/kitty/kitty.conf`](kitty/.config/kitty/kitty.conf)

| 快捷键 | 动作 |
| --- | --- |
| `Alt + Shift + B` | 水平分屏（上下排列） |
| `Alt + Shift + V` | 垂直分屏（左右排列） |
| `Ctrl + Shift + W` | 关闭当前窗格 |
| `Ctrl + Shift + H` / `Ctrl + Shift + ←` | 焦点移到左侧窗格 |
| `Ctrl + Shift + J` / `Ctrl + Shift + ↓` | 焦点移到下方窗格 |
| `Ctrl + Shift + K` / `Ctrl + Shift + ↑` | 焦点移到上方窗格 |
| `Ctrl + Shift + L` / `Ctrl + Shift + →` | 焦点移到右侧窗格 |
| `Ctrl + 鼠标点击 URL` | 打开终端中的链接 |

## Zsh（无 Oh My Zsh 备用配置）

以下内容只适用于手动启用
[`variants/zsh/zshrc.no-oh-my-zsh`](variants/zsh/zshrc.no-oh-my-zsh) 的情况；默认 `.zshrc`
会加载系统提供的 CachyOS Zsh 配置，其内置快捷键不由本仓库直接定义。

| 快捷键 | 动作 | 条件 |
| --- | --- | --- |
| `Ctrl + R` | 使用 Fzf 搜索命令历史 | 已安装 `fzf` 且处于交互式终端 |
| `↑` | 按当前输入内容向前搜索历史 | 已安装 `zsh-history-substring-search` |
| `↓` | 按当前输入内容向后搜索历史 | 已安装 `zsh-history-substring-search` |

## Waybar 鼠标操作

配置来源：[`waybar/.config/waybar/config`](waybar/.config/waybar/config)

| 区域与操作 | 动作 |
| --- | --- |
| 点击工作区 | 切换到所选工作区 |
| 点击网络 | 打开网络连接编辑器 |
| 点击蓝牙 | 打开蓝牙管理器 |
| 点击音量 | 打开 PulseAudio 音量控制器 |
| 右键点击音量 | 切换默认输出设备静音状态 |
| 在亮度区域向上滚动 | 屏幕亮度增加 5% |
| 在亮度区域向下滚动 | 屏幕亮度降低 5% |

> 修改快捷键后，请同步更新本文件，避免速查表与实际配置不一致。
