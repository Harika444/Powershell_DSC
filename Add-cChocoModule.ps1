$testModulePath ='C:\Program Files\WindowsPowerShell\Modules\cChoco'
If(Test-Path $env:TEMP\CChoco_2.4.0.0.zip)
{

Remove-Item $env:TEMP\CChoco_2.4.0.0.zip -Force
}

"Compressing the module xDismFeature to $env:Temp\CChoco_2.4.0.0.zip" | Write-Host
Add-Type -A System.IO.Compression.FileSystem
[IO.Compression.ZipFile]::CreateFromDirectory($testModulePath, "$env:Temp\CChoco_2.4.0.0.zip")
$moduleUploadFolder = "$env:C:\Program Files\WindowsPowerShell\Modules\"

If(Test-Path "$moduleUploadFolder\CChoco_2.4.0.0.zip"){
Remove-Item "$moduleUploadFolder\CChoco_2.4.0.0.zip" -Force
Remove-Item "$moduleUploadFolder\CChoco_2.4.0.0.zip.checksum" -Force
}

"Moving the compressed folder to module share location $moduleUploadFolder" | Write-Host
Move-Item -Path $env:TEMP\CChoco_2.4.0.0.zip -Destination "$moduleUploadFolder"

"Creating Checksum" | Write-Host
New-DscChecksum -Path $moduleUploadFolder -Force