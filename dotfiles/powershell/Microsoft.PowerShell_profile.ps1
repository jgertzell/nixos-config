find ~/dev/FO.CLI -iname *.psm1 | % {Import-Module -Force -Name $_}
Import-Module -Name ~/dev/StsGen2/tools/cli/FO.STS.Developer.psm1
$env:PATH = "$HOME/.dotnet/tools$([IO.Path]::PathSeparator)$env:PATH"
$env:SSL_CERT_DIR = "/etc/ssl/certs:$HOME/.aspnet/dev-certs/trust"
$env:LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib"
if (Test-Path ~/dev/FO.OMS/tools/FO.OMS/FO.OMS.psd1) {
  #Import-Module -Name ~/dev/FO.OMS/tools/FO.OMS/FO.OMS.psd1 -Force
}
if (Test-Path ~/dev/FO.Ordering.AI/Scripts) {
  #Get-ChildItem -Path ~/dev/FO.Ordering.AI/Scripts -File -Include *.ps1,*.psm1 -Recurse | ForEach-Object { . $_.FullName }
}
Set-PSReadLineOption -EditMode Windows
