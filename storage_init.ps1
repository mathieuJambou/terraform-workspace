$RANDOM = Get-Random -Minimum 100000 -Maximum 999999

$RESOURCE_GROUP_NAME='tadmin'
$STORAGE_ACCOUNT_NAME='tstate' + $RANDOM
$CONTAINER_NAME='tstate'
$KEYVAULT_NAME='tvault'
$KEY_BACKEND_NAME='terraform-backend-key'

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
$ACCOUNT_KEY=az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

az keyvault create --resource-group $RESOURCE_GROUP_NAME --name $KEYVAULT_NAME

az keyvault secret set --name $KEY_BACKEND_NAME --vault-name $KEYVAULT_NAME --value $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"

$env:STORAGE_ACCOUNT_RG=$RESOURCE_GROUP_NAME
$env:STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT_NAME
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY


terraform init -backend-config="resource_group_name=$env:RESOURCE_GROUP_NAME" -backend-config="storage_account_name=$env:STORAGE_ACCOUNT_NAME"