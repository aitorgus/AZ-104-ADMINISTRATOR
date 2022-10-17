#Lectura de los usuarios actuales:
$usuarios_actuales=get-azureaduser

$usuariosaBorrar = Import-Csv -Path "C:\script\LogUsuariosCreados.csv" -Delimiter ";"

#Declaracion de Funciones
        Function Existe-azureUser () {
        #Bloque para definir los parámetros 
            # [Parameter(Mandatory)] -> Indica que el siguiente parámetro es OBLIGATORIO
        param ( 
        [Parameter(Mandatory)]
        [String]$UserPrincipalName 
        )
        if ($usuarios_actuales.userprincipalname -contains $usuarios.userPrincipalName) {
            return $true
        }else {
            return $false
        }

        }

foreach ($usuarios in $usuariosaBorrar)  {

    if ( Existe-azureUser $usuarios.userPrincipalName)
    {
    # Si el usuario está en Azure y en mi lista lo borro
        Remove-AzureADUser -ObjectId $usuarios.UserPrincipalName 
        $nombre=$usuarios.DisplayName
        write-host "El usuario $nombre ha sido borrado de la bbdd" -ForegroundColor red
    }
    else {
        # Si el usuario NO EXISTE en Azure
        $nombre1=$usuarios.DisplayName
        write-host "El usuario $nombre1 no existe en la bbdd" -ForegroundColor Yellow
    }  
    }
    