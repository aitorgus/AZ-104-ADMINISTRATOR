    
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
    #---------Importo Usuarios y grupos desde el "CSV" AsignarUsuariosaGrupos.csv------------

<# Los datos a introducir son estos. La primera cabecera "usuarios" pertenece a los nombres de  los usuarios y "Departamentos"
pertenece al nombre de los Grupos.

    usuarios;departamentos
    Pedro Sanchez;Marketing
    Santiago Abascal;Contabilidad
    Pablo Iglesias;RRHH
    Alberto Nunez;Cloud
    Isabel Ayuso;SAP
    Juanma Moreno;IT
#>

$GruposyUsuarios= Import-Csv -Path "AsignarUsuariosaGrupos.csv" -Delimiter ";"

foreach ($iterador in $GruposyUsuarios) {
    
         #Obtengo el nombre de usuario que hemos importado del csv, que está contenido en $GruposyUsuarios:

        <# La operación que estamos realizando es acceder a la propiedad "usuarios" del objeto GruposyUsuarios
        #>
         
        $nombre_usuario= $iterador.usuarios

         #Obtengo el nombre del departamento, que será el nombre de los grupos:
        $nombre_grupo= $iterador.departamentos

         #Extraigo el ID de los usuarios y de los grupos:

        <# En caso de que el parámetro "displayname" que recoge el nombre del usuario, coincida con el nombre de usuario
        importado desde el csv, extraido su ID, es importante entender que estos pasará en caso de que el usuario se haya 
        crado previamente. Este script, no crea los usuarios
        
        #>
        $id_usuario=$(get-azureaduser -filter "displayname eq '$nombre_usuario'").objectid
        $id_grupos= $(Get-AzureADGroup -filter "displayname eq '$nombre_grupo'").objectid

       if ($id_grupos -eq $null)
       { 
            write-host "El grupo:  $nombre_grupo no existe" -ForegroundColor Magenta 

       }
        else {
            if ($id_usuario -eq $null) {
                write-host "El usuario : $nombre_usuario no existe" -ForegroundColor Magenta
            
            }
            else {
                if(asignar_usuario_en_grupo $id_usuario $id_grupos){
                    write-host "El usuario : $nombre_usuario ya está dentro del grupo : $nombre_grupo" -ForegroundColor Yellow
                }
                 else {
                    Add-AzureADGroupMember -Object $id_grupos -RefObjectId $id_usuario
                    write-host "El usuario : $nombre_usuario ha sido asignado al grupo : $nombre_grupo" -ForegroundColor Green
                 }
            }
        }
}