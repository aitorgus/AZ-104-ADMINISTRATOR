$Userpassword = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

$UsuariosCreados = "LogUsuariosCreados.csv"
#Realizamos la importación de los datos de los usuarios a dar de alta en Azure.
$users = Import-Csv -Path "TablaUsuarios.csv" -Delimiter ";"

foreach ($usuarios in $users)
{
    $Userpassword.Password = $usuarios.userpassword
    New-AzureADUser -userPrincipalName $usuarios.userPrincipalName -DisplayName $usuarios.DisplayName -MailNickName $usuarios.MailNickName -PasswordProfile $Userpassword -AccountEnabled $true |select DisplayName,userPrincipalName,ObjectId | Export-Csv -Encoding UTF8 -Path $UsuariosCreados -NoTypeInformation -Delimiter ";" -Append
    
    $nombre=$usuarios.DisplayName
    write-host "El usuario $nombre ha sido creado" -ForegroundColor Green

    
}