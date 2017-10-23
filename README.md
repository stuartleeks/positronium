# positronium

A set of miscellaneous PowerShell utilities bundled up in a module.

## Requirements

positronium works with either full [PowerShell (v5+)](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-5.1) or [PowerShell 6 (xplat, "PowerShell Core")](https://docs.microsoft.com/en-us/powershell/azure/install-azurermps-maclinux?view=azurermps-4.4.1#step-1-install-powershell-6-beta)


## Installation

To install positronium, run `Install-Module -Name positronium -Scope CurrentUser` from powershell.

## Documentation

See the [documentation](docs/README.md) for details on the commands in positronium.

## Changelog

### v0.0.3 (Published 2017-10-23)

Add ConvertFrom-Base64 and ConvertTo-Base64

Add comment help (you can now `Get-Help ConvertFrom-Base64`)


### v0.0.1 (Published 2017-10-23)

Initial version (`ConvertFrom-Tabular`)
