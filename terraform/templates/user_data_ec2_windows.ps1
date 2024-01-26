
<powershell>
$workdir = "c:\installer\"
If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }
$source = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
$destination = "$workdir\firefox.exe"
if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}
Start-Process -FilePath "$workdir\firefox.exe" -ArgumentList "/S"
Start-Sleep -s 35
rm -Force $workdir/firefox*

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CircleCI-Public/circleci-server-windows-image-builder/master/windows/shutdown-scripts/ShutdownScript.ps1").Content
Invoke-Expression (Invoke-WebRequest -Uri "https://github.com/CircleCI-Public/circleci-server-windows-image-builder/blob/master/windows/provision-scripts/cleanup-useless-defaults.ps1").Content
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CircleCI-Public/circleci-server-windows-image-builder/master/windows/provision-scripts/install-ssh.ps1").Content
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CircleCI-Public/circleci-server-windows-image-builder/master/windows/provision-scripts/disable-windows-defender-scanner.ps1").Content
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CircleCI-Public/circleci-server-windows-image-builder/master/windows/provision-scripts/install-windows-updates.ps1").Content
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CircleCI-Public/circleci-server-windows-image-builder/master/windows/provision-scripts/configure-docker-daemon.ps1").Content
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CircleCI-Public/circleci-server-windows-image-builder/master/windows/provision-scripts/cleanup.ps1").Content
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/CircleCI-Public/circleci-server-windows-image-builder/master/windows/provision-scripts/enable-ec2launch.ps1").Content

</powershell>
