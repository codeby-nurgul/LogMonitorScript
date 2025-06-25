# Ayarlar
$logPath = "C:\Logs"
$archivePath = "$logPath\archive"
$reportPath = "$logPath\report.txt"
$daysOld = 7

# Rapor dosyasını sıfırla
"" | Out-File $reportPath

# Logları tara
Get-ChildItem -Path $logPath -Filter *.log | ForEach-Object {
    $file = $_.FullName
    $matches = Select-String -Path $file -Pattern "ERROR", "CRITICAL"
    
    if ($matches) {
        Add-Content -Path $reportPath -Value "==== $($_.Name) ===="
        $matches | ForEach-Object { Add-Content -Path $reportPath -Value $_.Line }
        Add-Content -Path $reportPath -Value "`n"
    }
}

# Arşiv klasörü oluşturulmamışsa oluştur
if (-Not (Test-Path -Path $archivePath)) {
    New-Item -ItemType Directory -Path $archivePath | Out-Null
}

# 7 günden eski log dosyalarını arşivle
Get-ChildItem -Path $logPath -Filter *.log | Where-Object {
    $_.LastWriteTime -lt (Get-Date).AddDays(-$daysOld)
} | ForEach-Object {
    $zipFile = "$archivePath\$($_.BaseName)_archived.zip"
    Compress-Archive -Path $_.FullName -DestinationPath $zipFile
    Remove-Item $_.FullName
}
