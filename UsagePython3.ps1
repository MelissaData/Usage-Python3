<#
.SYNOPSIS
    Runs the Melissa Usage Cloud API Python 3 sample.

.DESCRIPTION
    This script runs UsagePython3.py with python3, passing along the license.
    The Usage API reports the status and usage of the license sent in the
    request; it can only check that license.

    Overall flow:
      1. Resolve the license (parameter, prompt, or MD_LICENSE environment variable).
      2. Run UsagePython3.py with the license.

.PARAMETER license
    License string to check. Resolved in this order:
      1. This parameter.
      2. An interactive prompt, if the parameter was not supplied.
      3. The MD_LICENSE environment variable, if the prompt was left blank.

.PARAMETER quiet
    Accepted for parity with other sample scripts; not currently used to suppress output.

.EXAMPLE
    .\UsagePython3.ps1

.EXAMPLE
    .\UsagePython3.ps1 -license "<your_license_string>"
#>

######################### Parameters ##########################
param(
    $license = '',
    [switch]$quiet = $false
    )

########################## Main ############################
Write-Host "`n===================== Melissa Usage Cloud API ========================`n"

# Get license (either from parameters or user input)
if ([string]::IsNullOrEmpty($license) ) {
  $license = Read-Host "Please enter your license string"
}

# Check for License from Environment Variables
if ([string]::IsNullOrEmpty($license) ) {
  $license = $env:MD_LICENSE
}

if ([string]::IsNullOrEmpty($license)) {
  Write-Host "`nLicense String is invalid!"
  Exit
}

# Run project
python3 UsagePython3.py --license $license
