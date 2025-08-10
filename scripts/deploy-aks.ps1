# deploy-aks.ps1
# --------------------------------------------
# This script creates a Resource Group and AKS Cluster in Azure using Azure CLI.
# Make sure you are logged into Azure using `az login` before running.

# Set variables
# Variables
$resourceGroupName = "myrg03"
$location = "eastus"
$aksClusterName = "mymeeaks3"
$nodeCount = 1
$nodeVMSize = "Standard_B2s"
$ACR_NAME = "mymeeacr03"
$acrSku = "Basic"

# Create Resource Group
az group create `
  --name $resourceGroupName `
  --location $location

# Check if resource group creation was successful
if ($LASTEXITCODE -eq 0) {
  
  # Create ACR
  az acr create `
    --resource-group $resourceGroupName `
    --name $ACR_NAME `
    --sku $acrSku `
    --location $location `
    --admin-enabled false

  # Check if ACR creation was successful
  if ($LASTEXITCODE -eq 0) {

    # Create AKS and attach ACR
    az aks create `
      --resource-group $resourceGroupName `
      --name $aksClusterName `
      --node-count $nodeCount `
      --node-vm-size $nodeVMSize `
      --generate-ssh-keys `
      --enable-managed-identity `
      --network-plugin azure `
      --network-policy calico `
      --attach-acr $ACR_NAME
  }
}



#   # After the AKS cluster is created, you can configure kubectl to use the new cluster
# az aks get-credentials `
#   --resource-group $resourceGroupName `
#   --name $aksClusterName       

#  # Set the cluster subscription
# az account set --subscription 9a19641f-a0da-455d-9b90-51dc0d0cdfee
# # Get credentials for the AKS cluster
# az aks get-credentials --resource-group mymeerg01 --name mymeeaks --overwrite-existing


