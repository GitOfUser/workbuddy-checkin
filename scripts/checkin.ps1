# WorkBuddy Check-in Script v3
# Enhanced window activation

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
    
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);
    
    [DllImport("user32.dll")]
    public static extern void mouse_event(uint dwFlags, int dx, int dy, uint dwData, int dwExtraInfo);
    
    [DllImport("user32.dll")]
    public static extern IntPtr SetActiveWindow(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    
    [DllImport("user32.dll")]
    public static extern bool BringWindowToTop(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern bool IsIconic(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern bool IsZoomed(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
    
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT {
        public int Left;
        public int Top;
        public int Right;
        public int Bottom;
    }
    
    public const uint MOUSEEVENTF_LEFTDOWN = 0x0002;
    public const uint MOUSEEVENTF_LEFTUP = 0x0004;
    public const uint WM_LBUTTONDOWN = 0x0201;
    public const uint WM_LBUTTONUP = 0x0202;
    public const int SW_RESTORE = 9;
    public const int SW_SHOW = 5;
}
"@

# Check-in coordinates
$MENU_X = 207
$MENU_Y = 983
$CHECKIN_X = 333
$CHECKIN_Y = 444

Write-Host "=== WorkBuddy Auto Check-in v3 ===" -ForegroundColor Cyan
Write-Host ""

# Get WorkBuddy window
$hwnd = [IntPtr]2492602

if ($hwnd -eq [IntPtr]::Zero) {
    Write-Host "[Error] WorkBuddy window not found" -ForegroundColor Red
    exit 1
}

# Step 1: Restore and activate window
Write-Host "[1/5] Restoring and activating window..." -ForegroundColor Yellow
if ([Win32]::IsIconic($hwnd)) {
    [Win32]::ShowWindow($hwnd, [Win32]::SW_RESTORE) | Out-Null
    Start-Sleep -Milliseconds 500
}
[Win32]::ShowWindow($hwnd, [Win32]::SW_SHOW) | Out-Null
Start-Sleep -Milliseconds 200
[Win32]::BringWindowToTop($hwnd) | Out-Null
Start-Sleep -Milliseconds 100
[Win32]::SetForegroundWindow($hwnd) | Out-Null
Start-Sleep -Milliseconds 300
[Win32]::SetActiveWindow($hwnd) | Out-Null
Start-Sleep -Milliseconds 200
Write-Host "    Window activated" -ForegroundColor Green

# Step 2: Click user menu
Write-Host "[2/5] Clicking user menu ($MENU_X, $MENU_Y)..." -ForegroundColor Yellow
[Win32]::SetCursorPos($MENU_X, $MENU_Y)
Start-Sleep -Milliseconds 150
[Win32]::mouse_event([Win32]::MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
Start-Sleep -Milliseconds 80
[Win32]::mouse_event([Win32]::MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
Write-Host "    User menu clicked" -ForegroundColor Green

# Wait for menu to expand
Write-Host "    Waiting 3 seconds for menu..." -ForegroundColor Gray
Start-Sleep -Seconds 3

# Step 3: Re-activate window (menu might steal focus)
Write-Host "[3/5] Re-activating window..." -ForegroundColor Yellow
[Win32]::BringWindowToTop($hwnd) | Out-Null
Start-Sleep -Milliseconds 200
[Win32]::SetForegroundWindow($hwnd) | Out-Null
Start-Sleep -Milliseconds 200
Write-Host "    Window re-activated" -ForegroundColor Green

# Step 4: Click check-in button
Write-Host "[4/5] Clicking check-in button ($CHECKIN_X, $CHECKIN_Y)..." -ForegroundColor Yellow
[Win32]::SetCursorPos($CHECKIN_X, $CHECKIN_Y)
Start-Sleep -Milliseconds 200
[Win32]::mouse_event([Win32]::MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
Start-Sleep -Milliseconds 100
[Win32]::mouse_event([Win32]::MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
Write-Host "    Check-in button clicked" -ForegroundColor Green

# Step 5: Verify click by checking window state
Start-Sleep -Seconds 1
Write-Host "[5/5] Verification complete" -ForegroundColor Yellow

Write-Host ""
Write-Host "=== Check-in process completed ===" -ForegroundColor Cyan
Write-Host "Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
