
function Invoke-NgBuild {
    param (
        $TypeEnvirement
    )
    
    if ("hom" -eq $TypeEnvirement) {
        npm run buildhom
    } else {
        npm run buildprod
    }
}

function Remove-Diretory {
    param (
        $Diretory
    )
    
    if([System.IO.Directory]::Exists(($Diretory))){
        $DiretoryRemove = $Diretory;
        Remove-Item $DiretoryRemove -recurse
     }
}

function Invoke-ImageBuild {
    param (
        $ProjectName
    )

    docker image build -t $ProjectName .
    docker image prune -f
}

function Publish-ImgClient {    
    param([string] $DirectoryProject, 
            [string] $DiretoryEnvirement, 
            [string] $TypeEnvirement, 
            [string] $Project)
    
            $Display = "[INFO] --------Configuring Img Web App "
            $Display += $Project
            $Display += ' Envirement  '
            $Display += $TypeEnvirement
            $Display += '--------------------------------------------------------------------------------'
            
            Write-Output $Display
            $Display = '[INFO] --------Access Diretory Project-------------------------------------------------'
            Write-Output $Display
            Set-Location $DirectoryProject
            
            
            $Display = '[INFO] --------Invoke ng build-------------------------------------------------'
            Write-Output $display
            Invoke-NgBuild -TypeEnvirement $TypeEnvirement
            
            $Diretory = $DiretoryEnvirement+"\dist";
            Remove-Diretory -Diretory $Diretory
            
            $Display = '[INFO] --------Copy Files-------------------------------------------------'
            Write-Output $Display
            
            Copy-Item ".\dist\" -destination $DiretoryEnvirement  -recurse 
            Copy-Item Dockerfile  $DiretoryEnvirement
            
            $ProjectName = $Project+"-"+$TypeEnvirement
            
            Write-Output '[INFO] ----------Build Imagem-------------------------------------------------------------'
            Invoke-ImageBuild -ProjectName $ProjectName
}

