@echo off

:: Set variables for file paths
set "AgentUrl=https://raw.githubusercontent.com/danapsta/Arrow-Deployer/main/Agent.exe"
set "BeginScriptUrl=https://raw.githubusercontent.com/danapsta/Arrow-Deployer/main/Begin.ps1"
set "DesktopPath=%USERPROFILE%\Desktop"

:: Download Agent.exe and Begin.ps1 to Desktop
powershell -command "Invoke-WebRequest -Uri '%AgentUrl%' -OutFile '%DesktopPath%\Agent.exe'"
powershell -command "Invoke-WebRequest -Uri '%BeginScriptUrl%' -OutFile '%DesktopPath%\Begin.ps1'"

:: Run Begin.ps1 as Administrator
powershell -command "Start-Process powershell -ArgumentList '-File %DesktopPath%\Begin.ps1' -Verb RunAs"
