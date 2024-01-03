@echo off

:: set filename for temporary PS script
set PsScript=%~dpn0.ps1

:: Create Admin User Install
echo try { > %PsScript%
echo $webclient = New-Object System.Net.WebClient >> %PsScript%
echo $url = "https://www.dropbox.com/scl/fi/ak3ptf9si92qbot2zy6uq/645WindowsAgentSetup_VALID_UNTIL_2024_01_05.exe?rlkey=1mf32eseqx49kcrethhr7kvzx&dl=1" >> %PsScript%
echo $output = "C:\temp\Agent.exe" >> %PsScript%
echo $webClient.DownloadFile($url, $output) >> %PsScript%
echo Start-Process -FilePath C:\Temp\Agent.exe -ArgumentList '/quiet' -Verb RunAs -Wait >> %PsScript%
echo } >> %PsScript%

:: Create Non-Admin Prompt
echo catch { >> %PsScript%
echo $directory = get-location >> %PsScript%
echo $username = "admin" >> %PsScript%
echo $password = get-content "C:\Temp\Secret.txt" ^| ConvertTo-SecureString >> %PsScript%
echo $credential = New-Object System.Management.Automation.PSCredential($username, $password) >> %PsScript%
echo $webclient = New-Object System.Net.WebClient >> %PsScript%
echo $url = "https://www.dropbox.com/scl/fi/ak3ptf9si92qbot2zy6uq/645WindowsAgentSetup_VALID_UNTIL_2024_01_05.exe?rlkey=1mf32eseqx49kcrethhr7kvzx&dl=1" >> %PsScript%
echo $output = "C:\temp\Agent.exe" >> %PsScript%
echo $webClient.DownloadFile($url, $output) >> %PsScript%
echo Start-Process -FilePath "C:\Temp\Agent.exe" -Credential $credential -ArgumentList '/quiet' -Wait >> %PsScript%
echo } >> %PsScript%

:: Create SecureString
echo 01000000d08c9ddf0115d1118c7a00c04fc297eb01000000f2d2854f3cffc243a15c57e4bd140fb400000000020000000000106600000001000020000000407609619013df2791771a088bfe4b62bf199c68e93983eea4079c2491763cc0000000000e800000000200002000000047851b4d1b9c0a6b0ec62659e4628449ea4699b0052a4c1b33eda5ad8cb35d3f100000004e74ff625289d6d8c8c1ae0c0e230a08400000007fe8d65eb8373d18cd854bb4e3e5ed3b6e6b698de02014b6fa85132f13d0848a78084acef8ad633043cecb7ae177123fea3b975a32d9390e0b5937780c15f337 > C:\Temp\Secret.txt
powershell -executionpolicy bypass -file %PsScript%
del %PsScript%