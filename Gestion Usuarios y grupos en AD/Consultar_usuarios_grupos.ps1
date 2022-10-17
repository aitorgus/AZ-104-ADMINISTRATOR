#Consulto los usuarios que está en un grupo, dando como dato el ObjectID (que he consultado con get-azureadgroup)

$Usuarios_del_grupo = Get-AzureADGroupmember -ObjectID "e708d998-c57f-4e0c-a6c7-ccda2f191972"
$usuario=$Usuarios_del_grupo.DisplayName
write-host "El grupo contiene estos usuarios:  $usuario  " -ForegroundColo Yellow