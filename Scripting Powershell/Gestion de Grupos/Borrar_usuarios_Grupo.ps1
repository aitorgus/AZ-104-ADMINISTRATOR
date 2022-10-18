
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
        #Filtrando Usuarios del log
        $usuariosAsignables = Import-Csv -Path "C:\script\DIA14\LogUsuariosCreados.csv" -Delimiter ";"

        #Consulto los usuarios de mi grupo

            $Usuarios_Grupo_Departamento_It=Get-AzureADGroupMember -ObjectId "e708d998-c57f-4e0c-a6c7-ccda2f191972"

        #Selecciono y guardo mi grupo

            $Grupos_actuales=get-azureadgroup -ObjectId "e708d998-c57f-4e0c-a6c7-ccda2f191972"


            foreach ($usuarios in $usuariosAsignables ) {
             
                    if ( ComprobarUsuarioGrupo $usuarios.UserPrincipalName ) {
                        #---Si el usuario ya existe dentro del grupo, LO ELIMINO

                        Remove-AzureADGroupMember -ObjectId $Grupos_actuales.ObjectId -MemberId $usuarios.ObjectId

                        $nombre=$usuarios.DisplayName
                        $nombre_Grupo=$Grupos_actuales.DisplayName

                            write-host "El usuario $nombre ha sido eliminado del grupo $nombre_Grupo" -ForegroundColo Magenta
                    
                    }
                    else { 
                        #---Si el usuario no está DENTRO grupo, no hago nada
                        
                        

                        $nombre=$usuarios.DisplayName
                        $nombre_Grupo=$Grupos_actuales.DisplayName

                            write-host "El usuario $nombre no se encuentra en el grupo $nombre_Grupo " -ForegroundColo Yellow 

                            }
                    }

        