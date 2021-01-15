param([string] $PASTA_PROJETO, 
        [string] $PASTA_AMBIENTE, [string] $TIPO_AMBIENTE, 
            [int32]$PORT, [string] $PROJETO,
            [string] $NETWORK)


$nomeProjeto = $PROJETO+"-"+$TIPO_AMBIENTE
$buscarService = docker service ls -f "name=$PROJETO-$TIPO_AMBIENTE" -q

if ( $null -eq $buscarService ){
    $info = '[INFO] -----Criando Serviço '
    $info += $nomeProjeto
    $info += '--------------------------'    
    Write-Output $info
    docker service create --name=$nomeProjeto --network=$NETWORK  $nomeProjeto
    docker service update --publish-add published=$PORT,target=$PORT  $nomeProjeto
} else {
      $info = '[INFO] -----Atualizando Serviço '
      $info += $nomeProjeto
      $info += '--------------------------'    
    Write-Output $info  
      docker service update $nomeProjeto
}