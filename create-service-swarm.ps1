param([string] $PASTA_PROJETO, 
        [string] $PASTA_AMBIENTE, [string] $TIPO_AMBIENTE, 
        [int32]$PORT, [string] $PROJETO)



$buscarService = docker service ls -f "name=$PROJETO-$TIPO_AMBIENTE" -q

if ( $buscarService -eq $null )
{
    $info = '[INFO] -----Criando Serviço '
    $info += $PROJETO+"-"+$TIPO_AMBIENTE
    $info += '--------------------------'    
    Write-Output $info
    docker service create --name=$PROJETO-$TIPO_AMBIENTE  $PROJETO-$TIPO_AMBIENTE
    docker service update --publish-add published=$PORT,target=8087 $PROJETO-$TIPO_AMBIENTE
} else {
      $info = '[INFO] -----Atualizando Serviço '
      $info += $PROJETO+"-"+$TIPO_AMBIENTE
      $info += '--------------------------'    
    Write-Output $info  
      docker service update $PROJETO-$TIPO_AMBIENTE
}