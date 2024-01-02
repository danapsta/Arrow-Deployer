# Download the Agent Installer and Batch Script
$webClient = New-Object System.Net.WebClient
$url = "https://www.dropbox.com/scl/fi/ak3ptf9si92qbot2zy6uq/645WindowsAgentSetup_VALID_UNTIL_2024_01_05.exe?rlkey=1mf32eseqx49kcrethhr7kvzx&dl=1"
$output = "C:\temp\Agent.exe"
$webClient.DownloadFile($url, $output)

# PowerShell Script to Create a Batch File

# Define the path of the batch file
$batchFilePath = "C:\Temp\RunAgent.bat"

# Batch file content
$batchContent = '@echo off' + "`n" +
                'powershell -command "Start-Process -FilePath C:\Temp\Agent.exe -ArgumentList ''/quiet'' -Verb RunAs -Wait"'

# Write the content to the batch file
Set-Content -Path $batchFilePath -Value $batchContent

# Optional: Make the batch file executable
# If needed, uncomment the line below
# Set-ItemProperty -Path $batchFilePath -Name IsReadOnly -Value $false
