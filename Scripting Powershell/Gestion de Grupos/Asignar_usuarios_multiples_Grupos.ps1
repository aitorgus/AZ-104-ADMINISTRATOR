    
    #Declaracion de Funciones

        Function asignar_usuario_en_grupo () {
 
         #Defino los parámetros de la función
            param ( 
             [Parameter(Mandatory)]
             [String]$id_usuario ,
             [Parameter(Mandatory)]
             [string]$id_grupo
            
            )
          
          #Consulto los miembro y me quedo con con su --ObjectId
          $miembros= get-azureadgroupmember -objectid $id_grupo 

            if($miembros.objectid -eq $id_usuario)
            {
                return $true
            }
            else {
                return $false
            }
        

        }

#Importo Usuarios y grupos desde un .csv$GruposyUsuarios
$GruposyUsuarios= Import-Csv -Path "AsignarUsuariosaGrupos.csv" -Delimiter ";"

foreach ($iterador in $GruposyUsuarios) {
        
         
        $nombre_usuario= $iterador.usuarios
        $nombre_grupo= $iterador.departamentos

        #Extraigo el ID de los usuarios
        $id_usuario=$(get-azureaduser -filter "displayname eq '$nombre_usuario'").objectid
        $id_grupos= $(Get-AzureADGroup -filter "displayname eq '$nombre_grupo'").objectid

        if ( $GruposyUsuarios.departamentos -eq $null) {
            write-host "El usuario $nombre_usuario , no tiene asignado grupo"
        }else {
        
        }

       if ($id_grupos -eq $null)
       { 
            write-host "El grupo $nombre_grupo no existe" -ForegroundColor Magenta 

       }
        else {
            if ($id_usuario -eq $null) {
                write-host "El usuario $nombre_usuario no existe" -ForegroundColor Magenta
            
            }
            else {
                if(asignar_usuario_en_grupo $id_usuario $id_grupos){
                    write-host "El usuario $nombre_usuario ya está dentro del grupo $nombre_grupo" -ForegroundColor Yellow
                }
                 else {
                    Add-AzureADGroupMember -Object $id_grupos -RefObjectId $id_usuario
                    write-host "El usuario $nombre_usuario ha sido asignado al grupo $nombre_grupo" -ForegroundColor Green
                 }
            }
        }
}