param([string] $PASTA_PROJETO, 
        [string] $PASTA_AMBIENTE, [string] $TIPO_AMBIENTE, 
        [int32]$PORT, [string] $PROJETO)

$output = "[INFO] --------Configurando "
$output += $PROJETO
$output += ' Tipo de Ambiente:'
$output += $TIPO_AMBIENTE
        
Write-Output $output
Write-Output '[INFO] --------Acessando Pasta do Projeto-------------------------------------------------'
cd $PASTA_PROJETO

Write-Output '[INFO] --------Gerando jar----------------------------------------------------------------'
mvn package -DskipTests 

Write-Output '[INFO] --------Copiando Arquivos Para Pasta do Ambiente-----------------------------------'
copy target/$PROJETO.jar $PASTA_AMBIENTE  
copy Dockerfile  $PASTA_AMBIENTE

cd $PASTA_AMBIENTE

if([System.IO.File]::Exists("start-app.sh")){
   Remove-Item start-app.sh
}

Write-Output '[INFO] ---------Gerando Arquivo de Inicialização do Sistema--------------------------------' 

if($TIPO_AMBIENTE -eq "prod") {
   copy start-app-prod.sh start-app.sh
}elseif($TIPO_AMBIENTE -eq "hom") {
   copy start-app-hom.sh start-app.sh
}


Write-Output '[INFO] ----------Gerando Imagem-------------------------------------------------------------'
docker image build -t sisget-service-$TIPO_AMBIENTE .
docker image prune -f
#################################################################################################################################




