# Variables
$resourceGroupName = "mymeerg01"
$acrName = "mymeeacr01"                     # ACR name (not login server)
$imageName = "myapp"                        # Image name
$imageTag = "v1"                            # Tag (e.g., v1, latest)
$dockerfilePath = "./Dockerfile"           # Relative path to Dockerfile
$contextPath = "."                         # Build context (typically the project root)

# Get ACR login server
$acrLoginServer = az acr show `
  --name $acrName `
  --resource-group $resourceGroupName `
  --query "loginServer" `
  --output tsv

# Full image name
$imageFullName = "${acrLoginServer}/${imageName}:${imageTag}"

# Build and push the Docker image using ACR Build
az acr build `
  --registry $acrName `
  --image $imageFullName `
  --file $dockerfilePath `
  $contextPath
