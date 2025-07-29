# Variables
$resourceGroupName = "mymeerg01"
$acrName = "mymeeacr01"                     # ACR name
$imageName = "myapp"                        # Image name
$imageTag = "v1"                            # Tag
$dockerfilePath = "scripts/Dockerfile"      # Path to Dockerfile
$contextPath = "."                          # Build context

# Get ACR login server
$acrLoginServer = az acr show `
  --name $acrName `
  --resource-group $resourceGroupName `
  --query "loginServer" `
  --output tsv

# Full image name
$imageFullName = "${acrLoginServer}/${imageName}:${imageTag}"

Write-Host "ACR Login Server: $acrLoginServer"
Write-Host "Building image: $imageFullName"

# Login to ACR
az acr login --name $acrName

# Docker build
docker build -t $imageFullName -f $dockerfilePath $contextPath

# Docker push
docker push $imageFullName
