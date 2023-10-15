$linDevBoxLinkPath = Join-Path $PSScriptRoot lin-dev-box.lnk

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($linDevBoxLinkPath)
$Shortcut.TargetPath = "pwsh.exe"
$Shortcut.Arguments = '-ExecutionPolicy Bypass -File ".\Run-Container.ps1" -ImageName "lin-dev-box"'
$Shortcut.WorkingDirectory = $PWD
$Shortcut.Save()
