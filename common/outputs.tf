
output "rg_commonresourcegroup_name" {

  value = azurerm_resource_group.commonresourcegroup.name

}

output "sa_common_diag_primary_blob_endpoint" {

  value = azurerm_storage_account.storageaccount.primary_blob_endpoint

}

