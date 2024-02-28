# Vars
[string]$WDADesktop = "C:\Users\WDAGUtilityAccount\Desktop"
[string]$Application = Get-Location | Select-Object | %{$_.ProviderPath.Split("\")[-1]}
[string]$Cache = "$env:ProgramData\win32app\$Application"
[string]$LogonCommand = "LogonCommand.ps1"

# Cache resources
Remove-Item -Path "$Cache" -Recurse -Force -ErrorAction Ignore
Copy-Item -Path $PSScriptRoot -Destination "$Cache" -Recurse -Force -Verbose -ErrorAction Ignore
