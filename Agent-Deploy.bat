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
echo $directory = get-location >> %PsScript%
echo $username = admin >> %PsScript%
echo $password = get-content C:\Temp\Secret.txt | ConvertTo-SecureString >> %PsScript%
echo $credential = New-Object System.Management.Automation.PSCredential($username, $password) >> %PsScript%
echo $webclient = New-Object System.Net.WebClient >> %PsScript%
echo $url = "https://www.dropbox.com/scl/fi/ak3ptf9si92qbot2zy6uq/645WindowsAgentSetup_VALID_UNTIL_2024_01_05.exe?rlkey=1mf32eseqx49kcrethhr7kvzx&dl=1" >> %PsScript%
echo $output = "C:\temp\Agent.exe" >> %PsScript%
echo $webClient.DownloadFile($url, $output) >> %PsScript%
echo Start-Process -FilePath C:\Temp\Agent.exe -ArgumentList '/quiet' -Credential $credential -Verb RunAs -Wait >> %PsScript%
echo } >> %PsScript%

:: Create SecureString
echo 01000000d08c9ddf0115d1118c7a00c04fc297eb01000000c7ce6713a1df3c4294721522f2f666e90000000002000000000003660000c0000000100000006e3d3c59ea351506db3829ab0cf9498e0000000004800000a00000001000000092e2b9801f74ca748bf0af892e9f64a81000000009daed7787fa8265df33875decebe0a614000000929365f80567d23ede8707aed6e73a112a1ebdbc >> C:\Temp\Secret.txt

powershell -executionpolicy bypass -file %PsScript%
del %PsScript%