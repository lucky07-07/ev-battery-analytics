param([Parameter(Mandatory)] [string] $OutDir, [string[]] $Pages = @("Energy & climate", "Battery, models & anomalies"), [int] $RenderSeconds = 8)
# Selects each report page tab in Power BI Desktop and captures the window.
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
New-Item -ItemType Directory -Force $OutDir | Out-Null
$i = 1
foreach ($p in $Pages) {
    & "$here\uia_click.ps1" -Name $p
    Start-Sleep -Seconds $RenderSeconds
    & "$here\capture_window.ps1" -OutFile (Join-Path $OutDir ("page{0}.png" -f $i))
    $i++
}
