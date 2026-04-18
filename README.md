# WorkBuddy 每日签到工具

自动完成 WorkBuddy 每日签到，解放双手，不再错过积分！

## 功能特点

- 🚀 **自动检测**：自动检测 WorkBuddy 是否运行，未运行则自动启动
- 🤖 **智能签到**：自动点击用户菜单和签到按钮
- ⏰ **定时任务**：支持配置定时自动签到（推荐每天 09:00）
- 🔄 **多平台支持**：提供 PowerShell（Windows）和 Shell（Linux/macOS）两种版本

## 快速开始

### 前提条件

- 安装 [Playwright](https://playwright.dev/) CLI 工具
- WorkBuddy 已配置 QQ 浏览器内核
- 屏幕分辨率建议 1920x1080 或更高

### 安装运行

```bash
# 克隆项目
git clone https://github.com/GitOfUser/workbuddy-checkin.git

# 进入目录
cd workbuddy-checkin

# 运行脚本
bash scripts/workbuddy_checkin.sh  # Linux/macOS
# 或
.\scripts\checkin.ps1              # Windows PowerShell
```

## 项目结构

```
workbuddy-checkin/
├── scripts/
│   ├── checkin.ps1              # PowerShell 签到脚本
│   └── workbuddy_checkin.sh     # Shell 签到脚本
├── SKILL.md                     # 技能配置说明
└── README.md                    # 项目说明
```

## 签到流程

1. 检测 WorkBuddy 是否运行，未运行则启动
2. 等待程序加载（约 3-5 秒）
3. 点击左下角用户菜单（CSS: `.user-menu`）
4. 等待菜单展开（约 2 秒）
5. 点击「立即领取 →」按钮（CSS: `.daily-checkin-banner-action`）

## 定时任务配置

推荐配合 Windows 任务计划程序使用：

- **任务名称**：WorkBuddy每日签到
- **触发时间**：每天 09:00
- **操作**：执行 PowerShell 脚本
- **程序路径**：`powershell.exe`
- **参数**：`-ExecutionPolicy Bypass -File "C:\path\to\checkin.ps1"`

## 注意事项

1. 每步操作之间需要适当等待，确保界面渲染完成
2. 建议添加重试机制（最多 3 次）
3. 在无人值守环境下运行效果最佳
4. DOM 结构可能随版本更新变化，需定期验证 CSS Selector
5. 确保 WorkBuddy 窗口在主显示器上可见

## 故障排除

| 问题 | 可能原因 | 解决方案 |
|------|----------|----------|
| 找不到用户菜单 | 界面未完全加载 | 增加等待时间至 5 秒 |
| 签到按钮不可见 | 菜单未展开 | 确保先点击用户菜单 |
| 点击无效 | 元素被遮挡 | 确保 WorkBuddy 窗口在最前 |
| 程序启动失败 | 路径错误 | 检查 WorkBuddy 安装路径 |

## 项目地址

👉 GitHub：[https://github.com/GitOfUser/workbuddy-checkin.git](https://github.com/GitOfUser/workbuddy-checkin.git)

如果觉得有用，欢迎 Star 支持！⭐