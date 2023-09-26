param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("lin-dev-box")]
    [string]$dockerName
)

$workingDir = Join-Path $PSScriptRoot $dockerName
$volumeName = "lin-dev-box"

Push-Location $workingDir
try {
    
    $existingVolumNames = docker volume ls -q | Where-Object { $_ -eq $volumeName }
    if (-not $existingVolumNames) {
        Write-Host "Creating '$volumeName'."
        docker volume create $volumeName | Out-Null
    } 
    docker run --rm -it -v "$($volumeName):/home/dev/mnt:rw" --network bridge -p 4000-4040:4000-4040 --name lin-dev-box "$($dockerName):dev"
}
finally {
    Pop-Location
}