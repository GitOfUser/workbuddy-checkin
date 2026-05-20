import ctypes
import time
from datetime import datetime

# Win32 API
user32 = ctypes.windll.user32

# 签到坐标（1920x1080 分辨率下验证）
MENU_X = 207
MENU_Y = 983
CHECKIN_X = 93
CHECKIN_Y = 566

MOUSEEVENTF_LEFTDOWN = 0x0002
MOUSEEVENTF_LEFTUP = 0x0004

print("=== WorkBuddy Auto Check-in via Python ===")

# Find WorkBuddy window
hwnd = user32.FindWindowW(None, "WorkBuddy")
if not hwnd:
    print("[Error] WorkBuddy window not found")
    exit(1)

print(f"Found WorkBuddy window: Handle = {hwnd}")

# Step 1: Activate window
print("[1/5] Activating window...")
user32.ShowWindow(hwnd, 3)  # SW_MAXIMIZE
time.sleep(0.5)
user32.SetForegroundWindow(hwnd)
time.sleep(0.3)
user32.BringWindowToTop(hwnd)
time.sleep(0.2)
print("    Window activated")

# Step 2: Click user menu
print(f"[2/5] Clicking user menu ({MENU_X}, {MENU_Y})...")
user32.SetCursorPos(MENU_X, MENU_Y)
time.sleep(0.15)
user32.mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
time.sleep(0.08)
user32.mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
print("    User menu clicked")

# Step 3: Wait for menu
print("    Waiting 3 seconds for menu...")
time.sleep(3)

# Step 4: Re-activate window
print("[3/5] Re-activating window...")
user32.BringWindowToTop(hwnd)
time.sleep(0.2)
user32.SetForegroundWindow(hwnd)
time.sleep(0.2)
print("    Window re-activated")

# Step 5: Click check-in button
print(f"[4/5] Clicking check-in button ({CHECKIN_X}, {CHECKIN_Y})...")
user32.SetCursorPos(CHECKIN_X, CHECKIN_Y)
time.sleep(0.2)
user32.mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
time.sleep(0.1)
user32.mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
print("    Check-in button clicked")

time.sleep(1)
print("[5/5] Verification complete")

print()
print("=== Check-in process completed ===")
print(f"Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
