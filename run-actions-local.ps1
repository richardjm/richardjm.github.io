param(
  [ValidateSet("pr", "deploy")]
  [string]$Workflow = "pr"
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "Checking required tools..."
if (-not (Get-Command podman -ErrorAction SilentlyContinue)) {
  throw "podman is not installed or not in PATH"
}
if (-not (Get-Command act -ErrorAction SilentlyContinue)) {
  throw "act is not installed or not in PATH"
}

Write-Host "Ensuring Podman machine is running..."
$machineState = (podman machine inspect --format "{{.State}}" 2>$null | Out-String).Trim()
if ($LASTEXITCODE -ne 0) {
  throw "Unable to inspect podman machine state"
}

if ($machineState -match "(?i)^running$") {
  Write-Host "Podman machine is already running"
} else {
  Write-Host "Starting Podman machine..."
  podman machine start | Out-Null
}

Write-Host "Resolving Podman Docker-compatible endpoint..."
$inspectJson = podman machine inspect | Out-String | ConvertFrom-Json
$machine = $inspectJson[0]

$dockerHost = $null
if ($machine.ConnectionInfo.PodmanPipe -and $machine.ConnectionInfo.PodmanPipe.Path) {
  $pipe = $machine.ConnectionInfo.PodmanPipe.Path -replace "\\", "/"
  # Pipe paths from podman machine inspect are already in correct format like //./pipe/podman-machine-default
  $dockerHost = "npipe://$pipe"
  Write-Host "Using Podman pipe: $($machine.ConnectionInfo.PodmanPipe.Path)"
} elseif ($machine.ConnectionInfo.PodmanSocket -and $machine.ConnectionInfo.PodmanSocket.Path) {
  $dockerHost = "unix://" + $machine.ConnectionInfo.PodmanSocket.Path
  Write-Host "Using Podman socket: $($machine.ConnectionInfo.PodmanSocket.Path)"
} else {
  # Fallback to default
  $dockerHost = "npipe://./pipe/podman-machine-default"
  Write-Host "Using fallback Docker host configuration"
}

if (-not $dockerHost) {
  throw "Failed to determine Docker host from podman machine connection info"
}

$env:DOCKER_HOST = $dockerHost
Write-Host "DOCKER_HOST=$env:DOCKER_HOST"

$commonArgs = @(
  "-P", "ubuntu-latest=ghcr.io/catthehacker/ubuntu:full-latest",
  "--container-daemon-socket", $env:DOCKER_HOST
)

if ($Workflow -eq "pr") {
  Write-Host "Running PR workflow build job..."
  act pull_request -W .github/workflows/pr-build.yml -j build @commonArgs
} else {
  Write-Host "Running deploy workflow build job..."
  act push -W .github/workflows/deploy.yml -j build @commonArgs
}

exit $LASTEXITCODE
