$SCRIPT_1="D:\Danillo\Desenvolvimento\Docker\sisget-compose\img-docker-service.ps1"
$SCRIPT_2="D:\Danillo\Desenvolvimento\Docker\sisget-compose\create-service-swarm.ps1"

$PASTA_PROJETO="D:\Danillo\Desenvolvimento\Projetos\workspace\sisget-service"
$PASTA_AMBIENTE='D:\Danillo\Desenvolvimento\Docker\sisget-compose\sisget-hom'
$TIPO_AMBIENTE='hom'
$PORT=8082
$PROJETO="sisget-service"

powershell.exe  -file $SCRIPT_1 -PASTA_PROJETO $PASTA_PROJETO -PASTA_AMBIENTE $PASTA_AMBIENTE -TIPO_AMBIENTE $TIPO_AMBIENTE -PORT $PORT -PROJETO $PROJETO
powershell.exe  -file $SCRIPT_2 -PASTA_PROJETO $PASTA_PROJETO -PASTA_AMBIENTE $PASTA_AMBIENTE -TIPO_AMBIENTE $TIPO_AMBIENTE -PORT $PORT -PROJETO $PROJETO
pause

