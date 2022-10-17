#Consulto los Grupos existentes 

$Grupos_actuales=get-azureadgroup 

#Consulto los usuarios existentes

$usuarios_actuales=get-azureaduser

#Guardo el ID 
$Identificador_grupo = $Grupos_actuales.ObjectId 

#Sintaxis   Add-AzureADGroupMember -ObjectId "Id Grupo" -RefObjectId "Id usuario" 

foreach ($usuarios in $usuarios_actuales)
{
    Add-AzureADGroupMember -ObjectId "e708d998-c57f-4e0c-a6c7-ccda2f191972" -RefObjectId $usuarios_actuales.ObjectId

}

       