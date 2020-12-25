# terraform-workspace

./storage_init.ps1

common
terraform init -backend-config="resource_group_name=$env:RESOURCE_GROUP_NAME" -backend-config="storage_account_name=$env:STORAGE_ACCOUNT_NAME"

terraform apply

terraform-workspaces
terraform init -backend-config="resource_group_name=$env:RESOURCE_GROUP_NAME" -backend-config="storage_account_name=$env:STORAGE_ACCOUNT_NAME"

terraform workspace new dev
terraform apply -var-file="terraform-dev.tfvars" -var "resource_group_name=$env:RESOURCE_GROUP_NAME" -var "storage_account_name=$env:STORAGE_ACCOUNT_NAME"


terraform workspace new prod
terraform apply -var-file="terraform-prod.tfvars" -var "resource_group_name=$env:RESOURCE_GROUP_NAME" -var "storage_account_name=$env:STORAGE_ACCOUNT_NAME"