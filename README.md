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
# List roles in uses by users
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

## Manage User and Group

### User

```
# Search for user
Get-AzureADUser -SearchString "Ar"
Get-AzureADUser -SearchString "Ar"

# Create a user
$domain = "<your domaine>" # Replace with your domaine
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "<enter a password>"

$user = @{
 City = "Quebec"
 Country = "Canada"
 Department = "Test user"
 DisplayName = "Ford Prefect"
 GivenName = "Ford"
 JobTitle = "Technical Writer"
 UserPrincipalName = "FoPerfect@$domain"
 PasswordProfile = $PasswordProfile
 PostalCode = "19001"
 State = "QC"
 StreetAddress = "42 High Road"
 Surname = "Prefect"
 TelephoneNumber = "215-867-5309"
 MailNickname = "FoPrefect"
 AccountEnabled = $true
 UsageLocation = "CA"
}

$newUser = New-AzureADUser @user

$newUser | Format-List
```

### Group

```
Get-AzureADGroup

$group = Get-AzureADGroup -SearchString "Mark"

Get-AzureADGroupMember -ObjectId $group.ObjectId

Get-AzureADGroupOwner -ObjectId $group.ObjectId

# Create a new group
$group = @{
 DisplayName = "Ford Group"
 MailEnabled = $false
 MailNickName = "FordGroup"
 SecurityEnabled = $true
}

$newGroup = New-AzureADGroup @group

# Update the group description
Set-AzureADGroup -ObjectId $newGroup.ObjectId -Description "Group for Ford to use."

# Set Ford as the owner
$user = Get-AzureADUser -Filter "DisplayName eq 'Ford Prefect'"

Add-AzureADGroupOwner -ObjectId $newGroup.ObjectId -RefObjectId $user.ObjectId

# Add some user to the group
$users = Get-AzureADUser | Where {$_.CompanyName -eq "freddycoder software"}

foreach ($user in $users) {
 Add-AzureADGroupMember -ObjectId $newGroup.ObjectId -RefObjectId $user.ObjectId
}
```

There is a dashboard for users to manage there groups :

https://myapps.microsoft.com

In the dashboard, you can add external user to groups.

