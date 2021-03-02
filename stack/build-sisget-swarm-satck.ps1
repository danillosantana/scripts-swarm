Import-Module .\stack\build-img-client.ps1
Import-Module .\stack\build-img-service.ps1


$DirectoryProject="D:\Danillo\Desenvolvimento\Projetos\workspace\sisget-client\"
$DiretoryEnvirement='D:\Danillo\Desenvolvimento\apps\sisget-swar-stack\'
$TypeEnvirement='prod'


######################### Build Client Image #################################################
$ProjectClient="sisget-client"
$NameClient = $ProjectClient+"-"+$TypeEnvirement
docker image rm $NameClient --force
Publish-ImgClient -DirectoryProject $DirectoryProject  -DiretoryEnvirement $DiretoryEnvirement -TypeEnvirement $TypeEnvirement -Project $ProjectClient


######################## Build Service Image ##################################################
$DirectoryProject="D:\Danillo\Desenvolvimento\Projetos\workspace\sisget-service\"
$ProjectService="sisget-service"
$Port = 8087
Publish-ImgService  -PASTA_PROJETO $DirectoryProject -PASTA_AMBIENTE $DiretoryEnvirement -TIPO_AMBIENTE $TypeEnvirement -PORT $Port -PROJETO $ProjectService


####################### Build Stack ########################################################
Set-Location $DiretoryEnvirement
Write-Output '[INFO] ----------------- Swarm Stack Prod ---------------------------------------'
docker stack rm sisgetapp
docker stack deploy -c sisget-swarm-stack.yml sisgetapp
