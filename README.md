# AzureAD - Notes

## Getting started

powershell
```
# Install and import module
Find-Module AzureAD
Install-Module -Name AzureAD
Import-Module AzureAD

# Connect to AzureAD
$AzureADCredentials = Get-Credential -Message "Credential to connect to Azure AD"
Connect-AzureAD -Credential $AzureADCredentials

# Get basic information
Get-AzureADCurrentSessionInfo
Get-AzureADTenantDetail
Get-AzureADDomain

# To list all command
Get-Command -Module AzureAD
```
