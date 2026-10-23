param([Parameter(Mandatory)] [string] $Dax)
# Runs a DAX query against the model open in Power BI Desktop (local Analysis Services engine).
$dll = "C:\Program Files\WindowsApps\Microsoft.MicrosoftPowerBIDesktop_2.159.883.0_x64__8wekyb3d8bbwe\bin\Microsoft.PowerBI.AdomdClient.dll"
Add-Type -Path $dll
$proc = Get-Process msmdsrv -ErrorAction Stop | Select-Object -First 1
$port = (Get-NetTCPConnection -OwningProcess $proc.Id -State Listen | Where-Object LocalAddress -eq "127.0.0.1" | Select-Object -First 1).LocalPort
$conn = New-Object Microsoft.AnalysisServices.AdomdClient.AdomdConnection "Data Source=localhost:$port"
$conn.Open()
$db = $conn.Databases | Select-Object -First 1
# single local database: the connection already points at it
$cmd = $conn.CreateCommand(); $cmd.CommandText = $Dax
$reader = $cmd.ExecuteReader()
$rows = @()
while ($reader.Read()) {
    $o = [ordered]@{}
    for ($i = 0; $i -lt $reader.FieldCount; $i++) { $o[$reader.GetName($i)] = $reader.GetValue($i) }
    $rows += [pscustomobject]$o
}
$reader.Close(); $conn.Close()
$rows | Format-List
