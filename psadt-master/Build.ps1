# Vars
. ".\Global.ps1"

# intunewin
[string]$Uri = "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/raw/master"
[string]$Exe = "IntuneWinAppUtil.exe"

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
Move-Item -Path "$env:TEMP\Deploy-Application.intunewin" -Destination "$env:ProgramData\win32app\$Application\$Application.intunewin" -Force -Verbose
explorer $env:ProgramData\win32app
