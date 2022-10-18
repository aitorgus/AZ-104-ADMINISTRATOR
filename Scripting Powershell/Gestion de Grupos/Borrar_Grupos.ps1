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

    #El objetivo de este Script es el de crear un grupo, evitando que se repita los nombres
        $Grupos_actuales=get-azureadgroup

    #Realizamos la importación de los datos de los GRUPOS a dar de alta en Azure.
        $GruposBorrar = Import-Csv -Path "C:\script\DIA14\GruposCreados.csv" -Delimiter ";"


         foreach ( $grupo in $GruposBorrar ) {

                if ( $Grupos_actuales.ObjectId -contains $grupo.ObjectId) {
                    # Si existe un GRUPO con el mismo nombre
                    Remove-AzureADGroup -ObjectId $grupo.ObjectID

                    $nombreGrupo=$grupo.DisplayName
                    Write-Host "El grupo $nombreGrupo ha sido borrado" -ForegroundColor Magenta

                }else {
                       # si NO EXISTE el grupo

                        $nombreGrupo=$grupo.DisplayName
                        Write-Host "No se puede borrar a $nombreGrupo pues no existe " -foreground Green
    }

    } 