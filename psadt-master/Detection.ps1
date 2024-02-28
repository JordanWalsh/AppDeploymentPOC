# Build your detection script here
# Example as below

## $TeamsClassic = Test-Path C:\Users\*\AppData\Local\Microsoft\Teams\current\Teams.exe
## $TeamsNew = Get-ChildItem "C:\Program Files\WindowsApps" -Filter "MSTeams_*"

## if(!$TeamsClassic -and $TeamsNew){
##     Write-Host "Found it!"
##     exit 0
## } else {
##     exit 1
## }

if(!$TeamsClassic -and $TeamsNew){
    Write-Host "Found it!"
    exit 0
} else {
    exit 1
}