# Run Agent.exe with arguments as Administrator
Start-Process -FilePath "$env:USERPROFILE\Desktop\Agent.exe" -ArgumentList "/quiet" -Verb RunAs
