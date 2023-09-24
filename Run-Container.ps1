param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("lin-dev-box")]
    [string]$dockerName
)

$workingDir = Join-Path $PSScriptRoot $dockerName

Push-Location $workingDir
try {
    docker run --rm -it -v lin-dev-box:/home/dev/mnt:rw --name lin-dev-box "$($dockerName):dev"
}
finally {
    Pop-Location
}