param(
    [Parameter(Mandatory)] [string] $Name,          # accessible name of the element to press
    [string] $ProcessName = "PBIDesktop",
    [switch] $List                                    # list matching elements instead of pressing
)
# Presses a named button/tab in an app window through Windows UI Automation
# (Invoke, SelectionItem or Toggle pattern; the first element that supports one wins).
Add-Type -AssemblyName UIAutomationClient, UIAutomationTypes
$proc = Get-Process $ProcessName -ErrorAction Stop | Select-Object -First 1
$root = [System.Windows.Automation.AutomationElement]::RootElement
$cond = New-Object System.Windows.Automation.PropertyCondition ([System.Windows.Automation.AutomationElement]::ProcessIdProperty, $proc.Id)
$windows = $root.FindAll([System.Windows.Automation.TreeScope]::Children, $cond)
$nameCond = New-Object System.Windows.Automation.PropertyCondition ([System.Windows.Automation.AutomationElement]::NameProperty, $Name)
$found = @()
foreach ($w in $windows) { $found += $w.FindAll([System.Windows.Automation.TreeScope]::Descendants, $nameCond) }
if ($List -or -not $found) {
    "found $($found.Count) element(s) named '$Name'"
    $found | ForEach-Object { "  {0} | {1}" -f $_.Current.ControlType.ProgrammaticName, $_.Current.BoundingRectangle }
    return
}
foreach ($el in $found) {
    $pattern = $null
    if ($el.TryGetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern, [ref]$pattern)) { $pattern.Invoke(); "invoked '$Name'"; return }
    if ($el.TryGetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern, [ref]$pattern)) { $pattern.Select(); "selected '$Name'"; return }
    if ($el.TryGetCurrentPattern([System.Windows.Automation.TogglePattern]::Pattern, [ref]$pattern)) { $pattern.Toggle(); "toggled '$Name'"; return }
}
"no pressable element named '$Name'"
