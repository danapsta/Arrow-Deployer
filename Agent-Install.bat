@echo off

:: set filename for temporary PS script
set PsScript=%~dpn0.ps1
set BaScript=%~dpn0.bat

:: Create Temp Directory
echo $directoryPath = "C:\Temp" > %PsScript%
echo if (-not (Test-Path $directoryPath)) { >> %PsScript%
echo     new-item -path $directoryPath -ItemType Directory >> %PsScript%
echo } >> %PsScript%

:: Generate Admin Credential
echo $username = "admin" >> %PsScript%
echo $password = "fCC1nC" ^| ConvertTo-SecureString -AsPlainText -Force >> %PsScript%
echo $password ^| ConvertFrom-SecureString ^| Out-File "C:\Temp\Secret.txt" >> %PsScript%

:: Change Working Directory
echo Set-Location "C:\Temp" >> %PsScript%

:: Create Non-Admin Prompt
echo try { >> %PsScript%
echo $directory = get-location >> %PsScript%
echo $password = get-content "C:\Temp\Secret.txt" ^| ConvertTo-SecureString >> %PsScript%
echo $credential = New-Object System.Management.Automation.PSCredential($username, $password) >> %PsScript%
echo $webclient = New-Object System.Net.WebClient >> %PsScript%
echo $url = "https://www.dropbox.com/scl/fi/j3siavvx1e9k6whbvb27i/645WindowsAgentSetup_VALID_UNTIL_2024_02_06.exe?rlkey=cd32jucpv3i23tbtujczig02k&dl=1" >> %PsScript%
echo $output = "C:\temp\Agent.exe" >> %PsScript%
echo $webClient.DownloadFile($url, $output) >> %PsScript%
echo Start-Process -FilePath "C:\Temp\Agent.exe" -Credential $credential -ArgumentList '/quiet' -Wait >> %PsScript%
echo } >> %PsScript%

:: Catch Statement
echo catch { >> %PsScript%
echo write-host "Invalid" >> %PsScript%
echo } >> %PsScript%

powershell -executionpolicy bypass -file %PsScript%
del %PsScript%
del %BaScript%