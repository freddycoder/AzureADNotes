$AzureADCredentials = Get-Credential -Message "Credential to connect to Azure AD"
Connect-AzureAD -Credential $AzureADCredentials

Get-AzureADCurrentSessionInfo
Get-AzureADTenantDetail
Get-AzureADDomain

function Set-AzureADApplicationRedirectUrls(
    [string]$DisplayNameFilter,
    [string]$ReplyUrls,
    [string]$LogoutUrl,
    [bool]$PublicClient = $false
) {
    $ui = Get-AzureADApplication -Filter "DisplayName eq '$DisplayNameFilter'"

    Write-Host "Set-AzureADApplicationRedirectUrl Before change"
    Write-Host "ReplyUrls" $ui.ReplyUrls
    Write-Host "LogoutUrl" $ui.LogoutUrl

    Set-AzureADApplication -ObjectId $ui.ObjectId -ReplyUrls $ReplyUrls -PublicClient $PublicClient

    if ($LogoutUrl -ne "") {
        Set-AzureADApplication -ObjectId $ui.ObjectId -LogoutUrl $LogoutUrl
    }

    $ui = Get-AzureADApplication -Filter "DisplayName eq '$DisplayNameFilter'"

    Write-Host "Set-AzureADApplicationRedirectUrl After change"
    Write-Host "ReplyUrls" $ui.ReplyUrls
    Write-Host "LogoutUrl" $ui.LogoutUrl
}

Set-AzureADApplicationRedirectUrls `
    -DisplayNameFilter "ErabliereIU-Local" `
    -ReplyUrls "https://192.168.1.2:5001/signin-callback" `
    -LogoutUrl "https://192.168.1.2/signout-callback" `
    -PublicClient $true

Set-AzureADApplicationRedirectUrls `
    -DisplayNameFilter "ErabliereAPISwagger-Local" `
    -ReplyUrls "https://192.168.1.2:5001/api/oauth2-redirect.html" `
    -LogoutUrl "" `
    -PublicClient $true
