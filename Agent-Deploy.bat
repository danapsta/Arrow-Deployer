@echo off

:: set filename for temporary PS script
set PsScript=%~dpn0.ps1

:: Create Admin User Install
echo try { >> %PsScript%
echo $webclient = New-Object System.Net.WebClient >> %PsScript%
echo $url = "https://www.dropbox.com/scl/fi/ak3ptf9si92qbot2zy6uq/645WindowsAgentSetup_VALID_UNTIL_2024_01_05.exe?rlkey=1mf32eseqx49kcrethhr7kvzx&dl=1" >> %PsScript%
echo $output = "C:\temp\Agent.exe" >> %PsScript%
echo $webClient.DownloadFile($url, $output) >> %PsScript%
echo Start-Process -FilePath C:\Temp\Agent.exe -ArgumentList '/quiet' -Verb RunAs -Wait >> %PsScript%
echo } >> %PsScript%

:: Create Non-Admin Prompt
echo catch { >> %PsScript%
echo $credential = Get-Credential -Message "Enter Admin Credentials" >> %PsScript%
echo $webclient = New-Object System.Net.WebClient >> %PsScript%
echo $url = "https://www.dropbox.com/scl/fi/ak3ptf9si92qbot2zy6uq/645WindowsAgentSetup_VALID_UNTIL_2024_01_05.exe?rlkey=1mf32eseqx49kcrethhr7kvzx&dl=1" >> %PsScript%
echo $output = "C:\temp\Agent.exe" >> %PsScript%
echo $webClient.DownloadFile($url, $output) >> %PsScript%
echo Start-Process -FilePath C:\Temp\Agent.exe -ArgumentList '/quiet' -Credential $credential -Verb RunAs -Wait >> %PsScript%
echo } >> %PsScript%

powershell -executionpolicy bypass -file %PsScript%