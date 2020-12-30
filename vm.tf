resource "azurerm_virtual_machine" "vm-1" {
  name                  = "vm1"
  location              = "${azurerm_resource_group.resourcegroup.location}"
  resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
  network_interface_ids = ["${azurerm_network_interface.vm1-nic.id}"]
  vm_size               = "Standard_B1ms"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "#{Project.VM.Name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"         
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "#{Project.VM.Name}"
    admin_username = "#{Project.VM.Username}"
    admin_password = "#{Project.VM.Password}"
  }

  os_profile_windows_config {
      enable_automatic_upgrades = "true"
      provision_vm_agent = "true"
  }

  tags = azurerm_resource_group.resourcegroup.tags
}