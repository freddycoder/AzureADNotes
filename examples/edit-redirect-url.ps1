$AzureADCredentials = Get-Credential -Message "Credential to connect to Azure AD"
Connect-AzureAD -Credential $AzureADCredentials

Get-AzureADCurrentSessionInfo
Get-AzureADTenantDetail
Get-AzureADDomain

$ui = Get-AzureADApplication -Filter "DisplayName eq 'ErabliereIU-Local'"

Write-Host "ReplyUrls" $ui.ReplyUrls
Write-Host "LogoutUrl" $ui.LogoutUrl

Set-AzureADApplication -ObjectId $ui.ObjectId -ReplyUrls "https://192.168.1.2:5001/signin-callback" -PublicClient $true
Set-AzureADApplication -ObjectId $ui.ObjectId -LogoutUrl "https://192.168.1.2/signout-callback"

$ui = Get-AzureADApplication -Filter "DisplayName eq 'ErabliereIU-Local'"

Write-Host "ReplyUrls" $ui.ReplyUrls
Write-Host "LogoutUrl" $ui.LogoutUrl
