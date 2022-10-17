#Consulto los Grupos existentes 

$Grupos_actuales=get-azureadgroup



write-host "A continuacion se muestran los datos de los grupos de la Base de datos: " -ForegroundColor Green

        $Grupos_actuales