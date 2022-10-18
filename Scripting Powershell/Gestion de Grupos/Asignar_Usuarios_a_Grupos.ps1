 #Declaracion de Funciones

    #--Funcion para comprobar conexion de Connect-AzureAD

        Function ComprobarConexion () {
            try { Write-Host "Comprobando si la conexión está establecida..." -ForegroundColor Magenta
            $azconnect= Get-AzureADTenantDetail -ErrorAction stop
            $displayname=($azconnect).DisplayName
            write-host "Conexion establecida con : $displayname" -ForegroundColor Green
            }catch {
                write-host "No hay conexion establecida" -ForegroundColor Red
                break
            }
            
        }

        #Llamo a la funcion
        ComprobarConexion

#--Funcion para comprobar existencia de usuarios en el GRUPO

        Function ComprobarUsuarioGrupo () {
        #Bloque para definir los parámetros 
            # [Parameter(Mandatory)] -> Indica que el siguiente parámetro es OBLIGATORIO
        param ( 
        [Parameter(Mandatory)]
        [String]$UserPrincipalName 
        )
        if ( $Usuarios_Grupo_Departamento_It.UserPrincipalName -contains  $usuarios.UserPrincipalName) {
            return $true
        }else {
            return $false
        }

        }

        #Consulto los usuarios de mi grupo

            $Usuarios_Grupo_Departamento_It=Get-AzureADGroupMember -ObjectId "e708d998-c57f-4e0c-a6c7-ccda2f191972"

        #Selecciono y guardo mi grupo

            $Grupos_actuales=get-azureadgroup -ObjectId "e708d998-c57f-4e0c-a6c7-ccda2f191972"

        #Consulto los usuarios existentes en AZure Active directory

            $usuarios_actuales=get-azureaduser

            foreach ($usuarios in $usuarios_actuales )
                {
                    if ( ComprobarUsuarioGrupo $usuarios.UserPrincipalName ) {
                        #---Si el usuario ya existe dentro del grupo, lo descarto y no intento añadirlo al grupo

                        $nombre=$usuarios.DisplayName
                        $nombre_Grupo=$Grupos_actuales.DisplayName

                            write-host "El usuario $nombre ya está dentro del grupo $nombre_Grupo" -ForegroundColo Magenta
                    }
                    else {
                        #---Si el usuario, NO EXISTE lo creo

                        Add-AzureADGroupMember -ObjectId "e708d998-c57f-4e0c-a6c7-ccda2f191972" -RefObjectId $usuarios.ObjectId 

                        $nombre=$usuarios.DisplayName
                        $nombre_Grupo=$Grupos_actuales.DisplayName

                            write-host "El usuario $nombre ha sido añadido al grupo $nombre_Grupo " -ForegroundColo Green
                    }
    

        }

    