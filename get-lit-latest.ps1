

if (test-path env:LUVI_ARCH) {
  $LUVI_ARCH = $env:LUVI_ARCH
} else {
  if ([System.Environment]::Is64BitProcess) {
    $LUVI_ARCH = "Windows-amd64"
  } else {
    $LUVI_ARCH = "Windows-ia32"
  }
}
$LUVI_URL = "https://github.com/luvit/luvi/releases/latest/download/luvi-regular-$LUVI_ARCH.exe"
$LIT_URL = "https://github.com/wbx/lit/releases/latest/download/lit.zip"

function Download-File {
  param (
    [string]$url,
    [string]$file
  )
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12;
  Write-Host "Downloading $url to $file"
  $downloader = new-object System.Net.WebClient
  $downloader.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials;
  $downloader.DownloadFile($url, $file)
}

# Download Files
Download-File $LUVI_URL "luvi.exe"
Download-File $LIT_URL "lit.zip"

# Create lit.exe using lit
Start-Process ".\luvi.exe" -ArgumentList "lit.zip -- make lit.zip lit.exe luvi.exe" -Wait -NoNewWindow
# Cleanup
Remove-Item "lit.zip"
# Create luvit using lit
Start-Process ".\lit.exe" -ArgumentList "make github://luvit/luvit luvit.exe luvi.exe" -Wait -NoNewWindow
