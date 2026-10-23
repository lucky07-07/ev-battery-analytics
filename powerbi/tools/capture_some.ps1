param([Parameter(Mandatory)] [string] $OutDir, [int[]] $Pages = @(4, 5), [int] $RenderSeconds = 8)
# Restores the Desktop window, captures the given page numbers, then minimises it again.
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$names = @{ 1 = "1 · Overview"; 2 = "2 · Treatments & diagnoses"; 3 = "3 · Review timeliness"; 4 = "4 · Overturn risk (ML)"; 5 = "5 · Anomalies" }
Add-Type @"
using System; using System.Runtime.InteropServices;
public static class WinShow { [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int c); }
"@
& "$here\resize_window.ps1" -Width 2600 -Height 1500
Start-Sleep -Seconds 3
foreach ($n in $Pages) {
    & "$here\uia_click.ps1" -Name $names[$n]
    Start-Sleep -Seconds $RenderSeconds
    & "$here\capture_window.ps1" -OutFile (Join-Path $OutDir ("page{0}.png" -f $n))
}
$h = (Get-Process PBIDesktop | Select-Object -First 1).MainWindowHandle
[void][WinShow]::ShowWindow($h, 6)   # SW_MINIMIZE: give the screen back
"minimised again"
