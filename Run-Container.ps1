param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("lin-dev-box")]
    [string]$dockerName
)

$workingDir = Join-Path $PSScriptRoot $dockerName

Push-Location $workingDir
try {
    docker run --rm -it "$($dockerName):dev"
}
finally {
    Pop-Location
}