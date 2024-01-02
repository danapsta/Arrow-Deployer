@echo off

:: set filename for temporary PS script
set PsScript=%~dpn0.ps1

:: create the PS Script
(
echo function DownloadScript($url, $zipname, $folderName){
echo    $desktop = [Environment]::GetFolderPath("Desktop")
echo    Invoke-WebRequest -Uri $url -OutFile "$desktop\$zipname"
echo    Add-Type -AssemblyName System.IO.Compression.FileSystem
echo    [System.IO.Compression.ZipFile]::ExtractToDirectory("$desktop\$zipname", "$desktop")
echo    Remove-Item "$desktop\$zipname"
echo    Get-ChildItem -Path "$desktop\$folderName" ^| Move-Item -Destination $desktop
echo    Remove-Item "$desktop\$folderName" -recurse -force
echo }
echo $desktop = [Environment]::GetFolderPath("Desktop")
echo DownloadScript "https://github.com/danapsta/Arrow-Deploy/archive/refs/heads/main.zip" "Deploy.zip" "Deploy-main"
echo Start-Process -FilePath "$desktop\Deploy-main\Agent.exe" -ArgumentList '/quiet' -Verb RunAs -Wait
) > %PsScript%

powershell -executionpolicy bypass -file %PsScript%
