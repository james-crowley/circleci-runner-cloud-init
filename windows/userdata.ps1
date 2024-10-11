# Allow script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Ensure TLS 1.2 is used for secure web requests
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Define the runner configuration details
$runnerAuthToken = "your-runner-auth-token"  # Replace with your actual auth token

# Securely fetch the AWS instance ID using IMDSv2 (Instance Metadata Service v2)
$metadataTokenUrl = "http://169.254.169.254/latest/api/token"
$instanceIdUrl = "http://169.254.169.254/latest/meta-data/instance-id"

Write-Host "Fetching metadata token..."
$tokenHeaders = @{ "X-aws-ec2-metadata-token-ttl-seconds" = "21600" }
$token = Invoke-RestMethod -Method Put -Uri $metadataTokenUrl -Headers $tokenHeaders -ErrorAction Stop

Write-Host "Fetching instance ID using token..."
$instanceIdHeaders = @{ "X-aws-ec2-metadata-token" = $token }
$instanceId = Invoke-RestMethod -Uri $instanceIdUrl -Headers $instanceIdHeaders -ErrorAction Stop

$runnerName = $instanceId
Write-Host "Using instance ID for runner name: $runnerName"

# Get the installation directory dynamically
$installDirPath = "$env:ProgramFiles\CircleCI"

# Download and run the CircleCI runner installation script
$installScriptUrl = "https://raw.githubusercontent.com/james-crowley/circleci-runner-cloud-init/refs/heads/main/windows/Install-CircleCIRunner.ps1"
$installScriptPath = "C:\Install-CircleCIRunner.ps1"

Write-Host "Downloading the CircleCI runner installation script..."
Invoke-WebRequest -Uri $installScriptUrl -OutFile $installScriptPath -ErrorAction Stop
Write-Host "Script downloaded successfully."

# Execute the installation script
Write-Host "Running the CircleCI installation script..."
& $installScriptPath -RunnerName "$runnerName" -RunnerToken "$runnerAuthToken"

# Output status
Write-Host "CircleCI Runner setup complete!"
