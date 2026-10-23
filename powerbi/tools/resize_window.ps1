param([int] $Width = 2400, [int] $Height = 1400, [string] $ProcessName = "PBIDesktop")
# Restores and resizes the app's main window (it may extend past the screen; PrintWindow still renders it all).
Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class WinPos {
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
    [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr h, IntPtr after, int x, int y, int cx, int cy, uint flags);
}
"@
$proc = Get-Process $ProcessName -ErrorAction Stop | Select-Object -First 1
$h = $proc.MainWindowHandle
[void][WinPos]::ShowWindow($h, 9)   # SW_RESTORE (un-maximize so a custom size sticks)
[void][WinPos]::SetWindowPos($h, [IntPtr]::Zero, 0, 0, $Width, $Height, 0x0004 -bor 0x0040)  # NOZORDER | SHOWWINDOW
"resized to ${Width}x${Height}"
