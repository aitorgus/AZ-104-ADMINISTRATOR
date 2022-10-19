#Lectura de los usuarios actuales:
$usuarios_actuales=get-azureaduser

$usuariosaBorrar = Import-Csv -Path "LogUsuariosCreados.csv" -Delimiter ";"


foreach ($usuarios in $usuariosaBorrar)  {

    if ( $usuarios_actuales.userprincipalname -contains $usuarios.userPrincipalName)
    {
    # Si el usuario está en Azure y en mi lista lo borro
        Remove-AzureADUser -ObjectId $usuarios.UserPrincipalName 
        $nombre=$usuarios.DisplayName
        write-host "El usuario $nombre ha sido borrado de la bbdd" -ForegroundColor red
    
    }
    else {
        # Si el usuario NO EXISTE en Azure
        $nombre=$usuarios.DisplayName
        write-host "El usuario $nombre no existe en la bbdd" -ForegroundColor Yellow
    }
        
    }
    
    
