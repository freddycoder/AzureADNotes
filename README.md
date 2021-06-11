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
## Working with roles

```
# List roles in uses by a user
Get-AzureADDirectoryRole

# Get the global administrator role
$CompanyAdminRole = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Global Administrator"}

# Get member of admin role
Get-AzureADDirectoryRoleMember -ObjectId $CompanyAdminRole.ObjectId

# Get all available role
Get-AzureADDirectoryRoleTemplate

# Get the Security Administrator role template
$SecurityAdminRoleTemplate = Get-AzureADDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Security Administrator"}

# Activate the role
$SecurityAdminRole = Enable-AzureADDirectoryRole -RoleTemplateId $SecurityAdminRoleTemplate.ObjectId

# Get a user
$user = Get-AzureADUser | Where-Object {$_.DisplayName -eq "John Doe"}

# Assign the role to the user
Add-AzureADDirectoryRoleMember -RefObjectId $user.ObjectId -ObjectId $SecurityAdminRole.ObjectId
```

