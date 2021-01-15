param([string] $PASTA_PROJETO, 
        [string] $PASTA_AMBIENTE, [string] $TIPO_AMBIENTE, 
            [int32]$PORT, [string] $PROJETO)

$output = "[INFO] --------Configurando "
$output += $PROJETO
$output += ' Tipo de Ambiente:'
$output += $TIPO_AMBIENTE
        
Write-Output $output
Write-Output '[INFO] --------Acessando Pasta do Projeto-------------------------------------------------'
Set-Location $PASTA_PROJETO

Write-Output '[INFO] --------Gerando jar----------------------------------------------------------------'
# mvn package -DskipTests
Start-MVN 

Write-Output '[INFO] --------Copiando Arquivos-----------------------------------'
Copy-Item target/$PROJETO.jar $PASTA_AMBIENTE  
Copy-Item Dockerfile  $PASTA_AMBIENTE

Set-Location $PASTA_AMBIENTE

if([System.IO.File]::Exists("start-app.sh")){
   Remove-Item start-app.sh
}

Write-Output '[INFO] ---------Gerando Arquivo de Inicialização do Sistema--------------------------------' 

if($TIPO_AMBIENTE -eq "prod") {
   Copy-Item start-app-prod.sh start-app.sh
}elseif($TIPO_AMBIENTE -eq "hom") {
   Copy-Item start-app-hom.sh start-app.sh
}

$nomeProjeto = $PROJETO+"-"+$TIPO_AMBIENTE

Write-Output '[INFO] ----------Gerando Imagem-------------------------------------------------------------'
docker image build -t $nomeProjeto .
docker image prune -f

#################################################################################################################################
function Start-MVN {
   mvn package -DskipTests 
}



