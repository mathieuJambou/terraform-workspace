resource "azurerm_virtual_network" "terraformnetwork" {
    name                = "Vnet-${var.environment}"
    address_space       = ["10.0.0.0/16"]
    location            = var.azure_location
    resource_group_name = data.terraform_remote_state.shared_services.outputs.rg_commonresourcegroup_name

    tags = {
		environment = "upper(var.environment)"
    }
}

resource "azurerm_subnet" "terraformsubnet" {
    name                 = "Subnet-${var.environment}"
    resource_group_name  = data.terraform_remote_state.shared_services.outputs.rg_commonresourcegroup_name
    virtual_network_name = azurerm_virtual_network.terraformnetwork.name
    address_prefixes       = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "terraformpublicip" {
    name                         = "PublicIP-${var.environment}"
    location                     = var.azure_location
    resource_group_name          = data.terraform_remote_state.shared_services.outputs.rg_commonresourcegroup_name
    allocation_method            = "Dynamic"

    tags = {
		environment = upper(var.environment)
    }
}

resource "azurerm_network_security_group" "terraformnsg" {
    name                = "NetworkSecurityGroup-${var.environment}"
    location            = var.azure_location
    resource_group_name = data.terraform_remote_state.shared_services.outputs.rg_commonresourcegroup_name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
		environment = upper(var.environment)
    }
}

resource "azurerm_network_interface" "terraformnic" {
    name                        = "NIC-${var.environment}"
    location                    = var.azure_location
    resource_group_name         = data.terraform_remote_state.shared_services.outputs.rg_commonresourcegroup_name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.terraformsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.terraformpublicip.id
    }

    tags = {
		environment = upper(var.environment)
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "ni_nsg_association" {
    network_interface_id      = azurerm_network_interface.terraformnic.id
    network_security_group_id = azurerm_network_security_group.terraformnsg.id
}