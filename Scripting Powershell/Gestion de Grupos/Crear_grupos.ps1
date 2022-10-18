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
        $Group = Import-Csv -Path "C:\script\DIA14\TablaGrupos.csv" -Delimiter ";"
        $GruposCreados= "C:\script\DIA14\GruposCreados.csv"

    foreach ( $grupo in $Group ) {

            if ( $Grupos_actuales.DisplayName -contains $grupo.DisplayName) {
                # Si existe un GRUPO con el mismo nombre que los existente, no creo ese GRUPO
                $nombreGrupo=$grupo.DisplayName
                Write-Host "No puede crearse el grupo $nombreGrupo , pues ya existe" -ForegroundColor Red

            }else {
                   # si NO EXISTE, creo ese grupo

                    New-AzureADGroup -DisplayName $grupo.DisplayName -MailEnabled $false -SecurityEnabled $true -MailNickName "NoSet" |select DisplayName,ObjectId | Export-Csv -Encoding UTF8 -Path $GruposCreados -NoTypeInformation -Delimiter ";" -Append
                    
                    $nombreGrupo=$grupo.DisplayName
                    Write-Host "Se ha creado el grupo  $nombreGrupo " -foreground Green
}

} 



