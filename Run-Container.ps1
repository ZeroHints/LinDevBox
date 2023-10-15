param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("lin-dev-box")]
    [string]$ImageName
)

$workingDir = Join-Path $PSScriptRoot $ImageName
$volumeName = "lin-dev-box"

Push-Location $workingDir
try {
    
    $existingVolumNames = docker volume ls -q | Where-Object { $_ -eq $volumeName }
    if (-not $existingVolumNames) {
        Write-Host "Creating '$volumeName'."
        docker volume create $volumeName | Out-Null
    } 
    docker run --rm -it -v "$($volumeName):/home/dev/mnt:rw" --network bridge -p 4000-4040:4000-4040 --name lin-dev-box "$($ImageName):dev"
}
finally {
    Pop-Location
}