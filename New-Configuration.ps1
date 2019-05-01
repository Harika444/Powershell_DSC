$tempConfigPath = Join-Path $env:TEMP "DemoConfig"
if(-not(Test-Path $tempConfigPath -ErrorAction Silentlycontinue)){
New-Item -ItemType Directory -Force $tempConfigPath
}

.\Documents\PullServerDemoConfig.ps1 -Path $tempConfigPath

$configurationFolder = $tempConfigPath

"Creating checksum file at location $configurationFolder" | Write-Host
New-DscChecksum -Path $configurationFolder -OutPath $configurationFolder -Verbose -Force

$configUploadFolder = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\"
"Copying the configuration and checksum files to $configUploadFolder" | Write-Host
Copy-Item -Path "$configurationFolder\*" -Destination $configUploadFolder