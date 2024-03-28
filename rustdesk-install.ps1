$ErrorActionPreference = 'SilentlyContinue'

#Region Settings
# Variables
$Key = ""
$IpAddress = "10.22.10.222"

# The temporary folder where we will store and run the installer
$TempFolder = "C:\Temp\"
#EndRegion Settings

# Check if we are running in admin context
function Test-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    $p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}
if (-not (Test-IsElevated)) {
    Write-Error -Message "Access Denied. Please run with Administrator privileges."
    exit 1
}

# Check if RustDesk is already installed and exit if it is installed
if ((Test-Path -Path "C:\Program Files\RustDesk\RustDesk.exe")) {
    "RustDesk already installed."
    exit 0
}

# Create our temp folder if it doesn't exist
if (!(Test-Path -Path $TempFolder)) {
    New-Item -ItemType Directory -Force -Path $TempFolder
}

# Change the current location to the temp folder
Set-Location $TempFolder

# Download version 1.2.3-1 of RustDesk, output specific file name.
Invoke-WebRequest -Uri "https://github.com/rustdesk/rustdesk/releases/download/1.2.3-1/rustdesk-1.2.3-1-x86_64.exe" -Outfile rustdesk-1.2.3-1-x86_64.exe

# Rename the installer to configure the installer; Add host (Relay/API) and Key.
Rename-Item -Path .\rustdesk-1.2.3-1-x86_64.exe -NewName "rustdesk-host=$IpAddress,key=$Key,.exe"

# Run the installer silently
$Process = Start-Process -FilePath ".\rustdesk-host=$IpAddress,key=$Key,.exe" -ArgumentList "--silent-install" -PassThru

# Exit with what ever exit code the installer returns
exit $Process.ExitCode
