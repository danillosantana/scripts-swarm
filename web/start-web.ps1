Import-Module .\web\build-img-client.ps1
Import-Module .\web\build-client-swarm.ps1

$DirectoryProject="D:\Danillo\Desenvolvimento\Projetos\workspace\sisget-client\"
$DiretoryEnvirement='D:\Danillo\Desenvolvimento\apps\sisget\web\'
$TypeEnvirement='prod'
$Project="sisget-client"
$Port=8081
$Network="netApp"

Invoke-CleanSwarm -Name $Project"-"$TypeEnvirement
Publish-ImgClient -DirectoryProject $DirectoryProject  -DiretoryEnvirement $DiretoryEnvirement -TypeEnvirement $TypeEnvirement -Project $Project
Publish-SwarmClient -TypeEnvirement $TypeEnvirement -Project $Project -Network $Network -Port $Port