terraform {
  backend "azurerm" {
    container_name        = "tstate"
	key                   = "terraform.tfstate"
  }
}