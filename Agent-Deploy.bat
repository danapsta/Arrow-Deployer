@echo off

:: set filename for temporary PS script
set PsScript=%~dpn0.ps1

:: create the PS Script
echo function DownloadScript($url, $zipname, $folderName){ >> %PsScript%
echo    $desktop = [Environment]::GetFolderPath("Desktop") >> %PsScript%
echo    Invoke-WebRequest -Uri $url -OutFile "$desktop\$zipname" >> %PsScript%
echo    Add-Type -AssemblyName System.IO.Compression.FileSystem >> %PsScript%
echo    [System.IO.Compression.ZipFile]::ExtractToDirectory("$desktop\$zipName", "$desktop") >> %PSScript%
echo    Remove-Item "$desktop\$zipname" >> %PsScript%
echo    Get-ChildItem -Path "$desktop\$foldername" ^| Move-Item -Destination $desktop >> %PsScript%
echo    Remove-Item "$desktop\$foldername" -recurse -force >> %PsScript%
echo } >> %PsScript%

echo DownloadScript "https://github.com/danapsta/Arrow-Deploy/archive/refs/heads/main.zip" "Deploy.zip" "Deploy-main" >> %PsScript%
echo Start-Process -FilePath $desktop\$foldername\Agent.exe /quiet -Verb RunAs -Wait >> %PsScript%

powershell -executionpolicy bypass -file %PsScript%