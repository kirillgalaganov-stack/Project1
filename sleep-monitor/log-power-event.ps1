# Appends one line per Modern Standby transition to sleep-monitor/power-events.log.
# Triggered by the "SleepMonitor" scheduled task (Kernel-Power events 506/507).
param([string]$Reason = 'manual')

$logPath = Join-Path $PSScriptRoot 'power-events.log'

# Most recent Modern Standby transition from the System log
$evt = Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Kernel-Power'; Id=506,507} -MaxEvents 1 -ErrorAction SilentlyContinue
$state = if ($Reason -ne 'manual') { $Reason } else { switch ($evt.Id) { 506 { 'ENTER_STANDBY' } 507 { 'EXIT_STANDBY' } default { 'UNKNOWN' } } }

$wifi = Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Where-Object MediaType -eq 'Native 802.11' | Select-Object -First 1
$ip   = (Get-NetIPAddress -InterfaceAlias $wifi.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue).IPAddress
$ac   = (Get-CimInstance -Namespace root\wmi BatteryStatus -ErrorAction SilentlyContinue).PowerOnline
$wake = (powercfg /lastwake) -join ' | '

$line = '{0:s} {1} eventTime={2:s} wifi={3} ip={4} ac={5} lastwake=[{6}]' -f (Get-Date), $state, $evt.TimeCreated, $wifi.Status, $ip, $ac, $wake
Add-Content -Path $logPath -Value $line -Encoding UTF8
