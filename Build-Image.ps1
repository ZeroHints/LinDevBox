param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("lin-dev-box")]
    [string]$dockerName
)

$workingDir = Join-Path $PSScriptRoot $dockerName

Push-Location $workingDir
try {
    $date = Get-Date -Format "yyyyMMddHHmmss"
    docker build --rm --build-arg CACHEBUST=$date --progress=plain -f Dockerfile -t "$($dockerName):dev" .
# --no-cache
}
finally {
    Pop-Location
}