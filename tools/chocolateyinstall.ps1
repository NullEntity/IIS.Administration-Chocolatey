$ErrorActionPreference = 'Stop';

# Validate windows version, bitness, and elevated
If ($Env:IS_PROCESSELEVATED -eq "false") {
  Write-Error "Package installation must be run as admin"
}

If (((Get-OSArchitectureWidth -Compare 64) -eq $false) `
  -or ($Env:OS_PLATFORM -ne "Windows") `
  -or ([Environment]::OSVersion.Version -lt (New-Object 'Version' 6,1))) {
  Write-Error "IIS.Administration requires 64-bit Windows Server 2008 R2 or greater"
}

If ($Env:ChocolateyForceX86 -eq "true") {
  Write-Error "IIS.Administration requires a 64 bit architecture to install"
}

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/Microsoft/IIS.Administration/releases/download/v2.2.0/IIS.Administration.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url64bit      = $url64
  softwareName  = 'IIS.Administration*'
  checksum64    = 'A6DAF0488B59724A26E5BD634EB87B9DBCC7B86009DF2947D899FE21D7DE7A60'
  checksumType64= 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

$setupScript = Join-Path $toolsDir "setup/setup.ps1"
Start-ChocolateyProcessAsAdmin "& `'$setupScript`' Install"

    








