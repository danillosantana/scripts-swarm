$SCRIPT_1=".\service\build-img-service.ps1"
$SCRIPT_2=".\service\build-service-swarm.ps1"

$PASTA_PROJETO="D:\Danillo\Desenvolvimento\Projetos\workspace\sisget-service"
$PASTA_AMBIENTE='D:\Danillo\Desenvolvimento\apps\sisget\service'
$TIPO_AMBIENTE='prod'
$PORT=8087
$PROJETO="sisget-service"
$NETWORK="netApp"

$Name = $PROJETO+"-"+$TIPO_AMBIENTE
docker service rm  $Name
docker image rm $Name --force
powershell.exe  -file $SCRIPT_1 -PASTA_PROJETO $PASTA_PROJETO -PASTA_AMBIENTE $PASTA_AMBIENTE -TIPO_AMBIENTE $TIPO_AMBIENTE -PORT $PORT -PROJETO $PROJETO
powershell.exe  -file $SCRIPT_2 -PASTA_PROJETO $PASTA_PROJETO -PASTA_AMBIENTE $PASTA_AMBIENTE -TIPO_AMBIENTE $TIPO_AMBIENTE -PORT $PORT -PROJETO $PROJETO -NETWORK $NETWORK
pause

