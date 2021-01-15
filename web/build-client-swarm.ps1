function Publish-SwarmClient {
           param([string] $TypeEnvirement, 
                [string] $Project,
                [string] $Network,
                [int32] $Port)        
        
        $NameProject = $Project+"-"+$TypeEnvirement
        
        [string] $Info = '[INFO] -----Create Service '
        $Info += $NameProject
        $Info += '--------------------------'    
        Write-Output $Info
        docker service create --name=$NameProject --network=$Network --publish published=$Port,target=80 $NameProject
}

function Invoke-CleanSwarm {
    param (
        $Name
    )
 
    # $ID = docker service ls -f "name=$Name" -q
    docker service rm $Name 
    docker image rm $Name --force
}