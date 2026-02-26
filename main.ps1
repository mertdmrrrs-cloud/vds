[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

$CRDInstaller = "$env:TEMP\chromeremotedesktophost.msi"
$ChromeInstaller = "$env:TEMP\chrome_installer.exe"

# -----------------------------
# Chrome Remote Desktop MSI
# -----------------------------
Write-Output "📥 Chrome Remote Desktop indiriliyor..."
Start-BitsTransfer -Source "https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi" -Destination $CRDInstaller

Write-Output "⚙️ Chrome Remote Desktop kuruluyor..."
# MSI'lar için msiexec kullan
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$CRDInstaller`" /quiet /norestart" -Wait

Remove-Item $CRDInstaller -Force

# -----------------------------
# Google Chrome EXE
# -----------------------------
Write-Output "📥 Google Chrome indiriliyor..."
Start-BitsTransfer -Source "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -Destination $ChromeInstaller

Write-Output "⚙️ Google Chrome kuruluyor..."
Start-Process -FilePath $ChromeInstaller -ArgumentList "/silent /install" -Verb RunAs -Wait

Remove-Item $ChromeInstaller -Force

Write-Output "✅ Kurulum tamamlandı!"
