$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$setupScript = Join-Path $toolsDir "setup/setup.ps1"
Start-ChocolateyProcessAsAdmin "& `'$setupScript`' Uninstall"
