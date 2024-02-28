# Vars
. ".\Global.ps1"

# Install IntuneWin32App module
if(-not(Get-Module IntuneWin32App -ListAvailable)){
    Install-Module IntuneWin32App -Scope CurrentUser -Force
}

# Connect to MS Graph
Connect-MSIntuneGraph -TenantID "walshmdm.co.uk"

# Source content prep tool
if (-not(Test-Path -Path "$env:ProgramData\$Exe")){
    Invoke-WebRequest -Uri "$Uri/$Exe" -OutFile "$env:ProgramData\$Exe"
}

# Create app library
if (-not(Test-Path -Path "$env:ProgramData\win32app")){
    New-Item "$env:ProgramData\win32app"
}

# Execute content prep tool
$processOptions = @{
    FilePath = "$env:ProgramData\$Exe"
    ArgumentList  = "-c ""$Cache"" -s ""$Cache\Deploy-Application.ps1"" -o ""$env:TEMP"" -q"
    WindowStyle = "Maximized"
    Wait = $true
}
Start-Process @processOptions

# Rename and prepare for upload
Move-Item -Path $Win32Path -Destination $Win32Location -Force -Verbose
explorer $env:ProgramData\win32app

# Upload to Intune
$IntuneWinMetaData = Get-IntuneWin32AppMetaData -FilePath $Win32Location
$RequirementRule = New-IntuneWin32AppRequirementRule -Architecture "All" -MinimumSupportedWindowsRelease "W10_22H2"
$DetectionScriptFile = "$Cache\Detection.ps1"
$DetectionRule = New-IntuneWin32AppDetectionRuleScript -ScriptFile $DetectionScriptFile -EnforceSignatureCheck $false -RunAs32Bit $false
$InstallCommandLine = "Deploy-Application.ps1 -DeploymentType Install"
$UninstallCommandLine = "Deploy-Application.ps1 -DeploymentType Uninstall"
Add-IntuneWin32App -FilePath $Win32Location -DisplayName $Application -Description $Description -Publisher $Publisher -InstallExperience "system" -RestartBehavior "suppress" -DetectionRule $DetectionRule -RequirementRule $RequirementRule -InstallCommandLine $InstallCommandLine -UninstallCommandLine $UninstallCommandLine -Verbose

