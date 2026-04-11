#!/bin/bash
# workbuddy_checkin.sh - WorkBuddy 每日签到自动化脚本
# 使用 Playwright 执行浏览器自动化操作

# 配置
WORKBUDDY_URL="tencent-workbuddy://"
USER_MENU_SELECTOR='[class="user-menu"]'
CHECKIN_BUTTON_SELECTOR='[class="daily-checkin-banner-action"]'
LOAD_WAIT=3000
MENU_WAIT=2000
CHECKIN_WAIT=1000

echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始 WorkBuddy 签到..."

# 1. 打开 WorkBuddy
echo "[1/5] 打开 WorkBuddy 程序..."
playwright open "$WORKBUDDY_URL" 2>/dev/null || echo "WorkBuddy 可能已在运行"

# 2. 等待程序加载
echo "[2/5] 等待程序加载..."
playwright wait $LOAD_WAIT

# 3. 点击用户菜单
echo "[3/5] 点击用户菜单..."
playwright click "$USER_MENU_SELECTOR"

# 4. 等待菜单展开
echo "[4/5] 等待菜单展开..."
playwright wait $MENU_WAIT

# 5. 点击签到按钮
echo "[5/5] 点击签到按钮..."
playwright click "$CHECKIN_BUTTON_SELECTOR"

# 等待签到完成
playwright wait $CHECKIN_WAIT

# 6. 截图保存签到结果
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
playwright screenshot "checkin_result_${TIMESTAMP}.png" 2>/dev/null

echo "[$(date '+%Y-%m-%d %H:%M:%S')] WorkBuddy 签到完成！"
