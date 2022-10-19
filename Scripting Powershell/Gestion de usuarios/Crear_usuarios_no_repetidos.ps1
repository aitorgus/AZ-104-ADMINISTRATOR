# ----- Declaro variables---------------

#La contraseña no es un String, es un objeto, tengo que crear el objeto
$Userpassword = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

#Ruta del log donde guardaré los usuarios creados
$UsuariosCreados = "C:\script\LogUsuariosCreados.csv"

#Lectura de los usuarios actuales:
$usuarios_actuales=get-azureaduser

#Realizamos la importación de los datos de los usuarios a dar de alta en Azure.
$users = Import-Csv -Path "TablaUsuarios.csv" -Delimiter ";"

foreach ($usuarios in $users)

#-- Compruebo de que los usuarios ya creados, no coincide con los que quiero crear
    #-- Con "Contains", devuelve un valor booleano, comparan cadenas, en el momento de que encuentran una coincidencia, deja de comprobarse.
    #--- Este operador indica si un conjunto incluye un determinado elemento. Devuelve "True", cuando el lado derecho coincide con uno de los elementos del conjunto

{ if ($usuarios_actuales.userprincipalname -contains $usuarios.userPrincipalName)
    {
        #--SI EXISTE EL USUARIO, NO LO CREA

        #Si TRUE 
        $nombre=$usuarios.DisplayName
        write-host "El usuario $nombre no se puede crear porque ya existe" -ForegroundColo Yellow

        #FIN if
        }
        else {
        #---SI EXISTE, LO CREA

        #Si False

                 $Userpassword.Password = $usuarios.userpassword
                 New-AzureADUser -userPrincipalName $usuarios.userPrincipalName -DisplayName $usuarios.DisplayName -MailNickName $usuarios.MailNickName -PasswordProfile $Userpassword -AccountEnabled $true |select DisplayName,userPrincipalName,ObjectId | Export-Csv -Encoding UTF8 -Path $UsuariosCreados -NoTypeInformation -Delimiter ";" -Append
                 $nombre=$usuarios.DisplayName
                 write-host "El usuario $nombre ha sido creado" -ForegroundColor Green
                 
                 #FIN-else
        }
        #FIN foreach
}