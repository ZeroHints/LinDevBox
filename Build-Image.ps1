param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("lin-dev-box")]
    [string]$dockerName
)

$workingDir = Join-Path $PSScriptRoot $dockerName

Push-Location $workingDir
try {
    docker build --rm --no-cache -f Dockerfile -t "$($dockerName):dev" .
}
finally {
    Pop-Location
}