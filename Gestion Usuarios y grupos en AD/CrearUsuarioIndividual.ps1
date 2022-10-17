$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "London@1234"
New-AzureADUser -DisplayName "Pedro" -PasswordProfile $PasswordProfile -UserPrincipalName "Pedro@camacho91.onmicrosoft.com" -AccountEnabled $true -MailNickName "Pedro"
