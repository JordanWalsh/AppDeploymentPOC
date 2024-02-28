# Vars
[string]$WDADesktop = "C:\Users\WDAGUtilityAccount\Desktop"
[string]$Application = Get-Location | Select-Object | %{$_.ProviderPath.Split("\")[-1]}
[string]$Cache = "$env:ProgramData\win32app\$Application"
[string]$LogonCommand = "LogonCommand.ps1"
[string]$Uri = "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/raw/master"
[string]$Exe = "IntuneWinAppUtil.exe"
[string]$Win32Location = "$env:ProgramData\win32app\$Application\$Application.intunewin"
[string]$Win32Path = "$env:TEMP\Deploy-Application.intunewin"
[string]$TenantName = "walshmdm.co.uk" # Adjust based on client
[string]$Publisher = "Phoenix Software"
[string]$Description = "Test" # Adjust based on application

# Cache resources
Remove-Item -Path "$Cache" -Recurse -Force -ErrorAction Ignore
Copy-Item -Path $PSScriptRoot -Destination "$Cache" -Recurse -Force -Verbose -ErrorAction Ignore
