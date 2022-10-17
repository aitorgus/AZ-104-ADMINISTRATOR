#Creo un grupo de usuarios

New-AzureADGroup -DisplayName Departamento_IT -MailEnabled $false -SecurityEnabled $true -MailNickName "NoSet"