# WorkBuddy 每日签到工具

自动完成 WorkBuddy 每日签到，解放双手，不再错过积分！

## 功能特点

- 🚀 **自动检测**：自动检测 WorkBuddy 是否运行，未运行则自动启动
- 🤖 **智能签到**：通过 Windows API 模拟鼠标点击完成签到
- ⏰ **定时任务**：支持配置定时自动签到（默认每天 00:05）
- 🔧 **多版本支持**：提供 PowerShell、Python ctypes 和 Shell 三种实现方式

## 快速开始

### 前提条件

**方案一：Python ctypes（推荐）**
- 安装 Python 3.x
- WorkBuddy 已安装并配置 QQ 浏览器内核
- 屏幕分辨率建议 1920x1080 或更高

**方案二：PowerShell（Windows）**
- Windows PowerShell 5.1+
- WorkBuddy 已安装
- 注意：系统环境变量总长度不能超过 65535 字节

**方案三：Playwright（Linux/macOS）**
- 安装 [Playwright](https://playwright.dev/) CLI 工具
- WorkBuddy 支持 Linux/macOS 版本

### 安装运行

```bash
# 克隆项目
git clone https://github.com/GitOfUser/workbuddy-checkin.git

# 进入目录
cd workbuddy-checkin
```

#### 方案一：Python ctypes（⭐ 推荐）

```bash
# 确保 Python 已安装
python scripts/checkin_py.py
```

#### 方案二：PowerShell（Windows）

```powershell
# 直接运行
.\scripts\checkin.ps1
```

> ⚠️ **注意**：如果系统环境变量总长度超过 65535 字节，PowerShell 脚本会因 `Add-Type` 编译失败而静默失效，请改用 Python 版本。

#### 方案三：Playwright（Linux/macOS）

```bash
bash scripts/workbuddy_checkin.sh
```

## 项目结构

```
workbuddy-checkin/
├── scripts/
│   ├── checkin_py.py              # Python ctypes 签到脚本（推荐）
│   ├── checkin.ps1                # PowerShell 签到脚本
│   └── workbuddy_checkin.sh       # Shell 签到脚本（Playwright）
├── SKILL.md                       # 技能配置说明
└── README.md                      # 项目说明
```

## 签到流程

### Python/PowerShell 版本（基于坐标点击）

1. 检测 WorkBuddy 是否运行，未运行则启动
2. 激活并最大化 WorkBuddy 窗口
3. 移动鼠标到左下角用户菜单位置（X=207, Y=983）
4. 模拟鼠标点击用户菜单
5. 等待 3 秒让菜单展开
6. 重新激活窗口（防止焦点丢失）
7. 移动鼠标到签到按钮位置（X=93, Y=566）
8. 模拟鼠标点击「立即领取 →」按钮

### Playwright 版本（基于 CSS Selector）

1. 打开 WorkBuddy 程序
2. 等待程序加载（约 3 秒）
3. 点击用户菜单（CSS: `.user-menu`）
4. 等待菜单展开（约 2 秒）
5. 点击「立即领取 →」按钮（CSS: `.daily-checkin-banner-action`）
6. 截图保存签到结果

## 定时任务配置

### Windows 任务计划程序（推荐）

- **任务名称**：WorkBuddy每日签到
- **触发时间**：每天 00:05
- **操作**：执行 Python 脚本
- **程序路径**：`C:\Users\22915\AppData\Local\Programs\Python\Python39-32\python.exe`
- **参数**：`c:\Users\22915\WorkBuddy\20260405031040\checkin_py.py`
- **工作目录**：`c:\Users\22915\WorkBuddy\20260405031040`

### Linux/macOS cron

```bash
# 编辑 crontab
crontab -e

# 添加定时任务（每天 00:05 执行）
5 0 * * * /path/to/workbuddy-checkin/scripts/workbuddy_checkin.sh >> /var/log/workbuddy-checkin.log 2>&1
```

## 注意事项

1. **坐标依赖**：Python/PowerShell 版本依赖固定坐标，在 1920x1080 分辨率下测试
2. **窗口位置**：确保 WorkBuddy 窗口在主显示器上可见且未被遮挡
3. **时序控制**：每步操作之间已设置适当等待时间，确保界面渲染完成
4. **环境限制**：PowerShell 版本受系统环境变量长度限制（最大 65535 字节）
5. **分辨率适配**：如果屏幕分辨率改变，需要重新校准点击坐标
6. **无人值守**：建议在无人值守环境下运行，避免鼠标键盘冲突
7. **定期验证**：DOM 结构或窗口布局可能随版本更新变化，需定期验证

## 故障排除

| 问题 | 可能原因 | 解决方案 |
|------|----------|----------|
| PowerShell 脚本无反应 | 环境变量超长导致 Add-Type 失败 | 改用 Python ctypes 版本 |
| 找不到 WorkBuddy 窗口 | 程序未运行 | 先手动启动 WorkBuddy，等待 5 秒 |
| 点击无效 / 菜单未展开 | 坐标偏移或窗口位置变化 | 重新截图确认坐标，检查分辨率 |
| 签到按钮不可见 | 菜单未展开或焦点丢失 | 确保先点击用户菜单并等待 3 秒 |
| Playwright 命令不存在 | 未安装 Playwright | 运行 `npm install -g playwright` |
| 坐标点击位置错误 | 分辨率不是 1920x1080 | 调整分辨率或重新校准坐标 |

## 项目地址

👉 GitHub：[https://github.com/GitOfUser/workbuddy-checkin.git](https://github.com/GitOfUser/workbuddy-checkin.git)

如果觉得有用，欢迎 Star 支持！⭐