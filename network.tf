resource "azurerm_virtual_network" "network" {
    name                = "${azurerm_resource_group.resourcegroup.name}-network"
    address_space       = ["#{Project.AzureNetwork.VirtualNetwork}"]
    location            = azurerm_resource_group.resourcegroup.location
    resource_group_name = azurerm_resource_group.resourcegroup.name

    tags = azurerm_resource_group.resourcegroup.tags
}

resource "azurerm_subnet" "subnet" {
    name                 = "${azurerm_resource_group.resourcegroup.name}-subnet"
    resource_group_name  = azurerm_resource_group.resourcegroup.name
    virtual_network_name = azurerm_virtual_network.network.name
    address_prefix       = "#{Project.AzureNetwork.Subnet}"
}

resource "azurerm_network_interface" "vm1-nic" {
    name                        = "vm1-NIC"
    location                    = azurerm_resource_group.resourcegroup.location
    resource_group_name         = azurerm_resource_group.resourcegroup.name

    ip_configuration {
        name                          = "vm1-NicConfig"
        subnet_id                     = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "dynamic"
    }

    tags = azurerm_resource_group.resourcegroup.tags
}