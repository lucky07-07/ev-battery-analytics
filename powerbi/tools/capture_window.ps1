param(
    [Parameter(Mandatory)] [string] $OutFile,
    [string] $ProcessName = "PBIDesktop",
    [switch] $ListWindows
)
# Captures every visible top-level window of a process (main window + dialogs) with PrintWindow,
# which also renders WebView2/DirectComposition content (flag PW_RENDERFULLCONTENT = 2).
Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;
public static class Win {
    public delegate bool EnumProc(IntPtr h, IntPtr p);
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumProc cb, IntPtr p);
    [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint pid);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int n);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    [DllImport("user32.dll")] public static extern bool PrintWindow(IntPtr h, IntPtr hdc, uint flags);
    [StructLayout(LayoutKind.Sequential)] public struct RECT { public int L, T, R, B; }
    public static List<IntPtr> ForPid(uint pid) {
        var list = new List<IntPtr>();
        EnumWindows((h, p) => { uint w; GetWindowThreadProcessId(h, out w);
            if (w == pid && IsWindowVisible(h)) list.Add(h); return true; }, IntPtr.Zero);
        return list;
    }
    public static string Title(IntPtr h) { var s = new StringBuilder(512); GetWindowText(h, s, 512); return s.ToString(); }
}
"@
$proc = Get-Process $ProcessName -ErrorAction Stop | Select-Object -First 1
$i = 0
foreach ($h in [Win]::ForPid([uint32]$proc.Id)) {
    $r = New-Object Win+RECT
    [void][Win]::GetWindowRect($h, [ref]$r)
    $w = $r.R - $r.L; $hgt = $r.B - $r.T
    if ($w -lt 50 -or $hgt -lt 50) { continue }
    $title = [Win]::Title($h)
    if ($ListWindows) { "{0} | {1}x{2} at {3},{4} | '{5}'" -f $h, $w, $hgt, $r.L, $r.T, $title; continue }
    $bmp = New-Object System.Drawing.Bitmap $w, $hgt
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $hdc = $g.GetHdc()
    [void][Win]::PrintWindow($h, $hdc, 2)
    $g.ReleaseHdc($hdc); $g.Dispose()
    $path = if ($i -eq 0) { $OutFile } else { $OutFile -replace '\.png$', "_$i.png" }
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
    "saved $path ($w x $hgt) '$title'"
    $i++
}
