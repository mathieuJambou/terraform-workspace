resource "tls_private_key" "admin_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "LinuxVM" {
    name                  = "VM-${var.environment}"
    location              = "eastus"
    resource_group_name   = data.terraform_remote_state.shared_services.outputs.rg_commonresourcegroup_name
    network_interface_ids = [azurerm_network_interface.terraformnic.id]
    size                  = lookup(var.linux_vm_size, var.environment)

    os_disk {
        name              = "OsDisk${var.environment}"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "VM${upper(var.environment)}"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.admin_ssh.public_key_openssh
    }

    boot_diagnostics {
        storage_account_uri = data.terraform_remote_state.shared_services.outputs.sa_common_diag_primary_blob_endpoint
    }

    tags = {
        environment = upper(var.environment)
    }
}