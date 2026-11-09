# Registers the "SleepMonitor" scheduled task for the current user (no admin needed).
$script = Join-Path $PSScriptRoot 'log-power-event.ps1'

$xmlQuery = @'
<QueryList><Query Id="0" Path="System"><Select Path="System">*[System[Provider[@Name='Microsoft-Windows-Kernel-Power'] and (EventID=506 or EventID=507)]]</Select></Query></QueryList>
'@

$class   = Get-CimClass -ClassName MSFT_TaskEventTrigger -Namespace Root/Microsoft/Windows/TaskScheduler
$trigger = New-CimInstance -CimClass $class -ClientOnly -Property @{ Enabled = $true; Subscription = $xmlQuery }

$action   = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$script`""
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
Register-ScheduledTask -TaskName 'SleepMonitor' -Action $action -Trigger $trigger -Settings $settings -Force | Out-Null
