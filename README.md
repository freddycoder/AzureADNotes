# AzureAD - Notes

<!--ts-->
 * [Getting started](#getting-started)
 * [Working with roles](#working-with-roles)
 * [Manage User and Group](#manage-user-and-group)
   * [User](#user)
   * [Group](#group)
 * [Manage Devices and Applications](#manage-devices-and-applications)
   * [Devices](#devices)
   * [Applications](#applications)
 * [References](#references)
<!--te-->

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

## Manage Devices and Applications

### Devices

```
# List command with device
Get-Command -Module AzureAD "*device*"

Get-AzureADDevice | Format-List

$device = Get-AzureADDevice -ObjectId <objectId-guid-past-from-last-command>

Get-AzureADDeviceRegisteredOwner -ObjectId $device.ObjectId
Get-AzureADDeviceRegisteredUser -ObjectId $device.ObjectId

# Add a user to a device
$user = Get-AzureADUser -SearchString "Arthur Dent"

Add-AzureADDeviceRegisteredUser -ObjectId $device.ObjectId -RefObjectId $user.ObjectId

Disable a device
Set-AzureADDevice -AccountEnabled:$false -ObjectId $device.ObjectId
```

### Applications

Azure AD IDaaS (Identity as a Service)

```
Get-Command -Module AzureAD "*application*"

Get-Help <azureAdApplicationCommand>

Get-AzureADApplication

$app = New-AzureADApplication -DisplayName "Marketing App" -IdentifierUris "http://marketing.freddycoder.com"

$app | Format-List

New-AzureADServicePrincipal -AppId $app.AppId

Get-AzureADApplication
```

## References 

Pluralsight cours
- https://app.pluralsight.com/library/courses/microsoft-azure-active-directory-managing-identities/table-of-contents

AzureAD documentation repo
- https://github.com/Azure/azure-docs-powershell-azuread
