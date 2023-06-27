# IoC for simple test-environment (1 vm)
# 1 Azure Provider source and version being used
# 2 Configure the Microsoft Azure Provider
# 3 resource group
# 4 virtual network
# 5 subnet
# 6 network security group
# 7 network security rule
# 8 network subnet nsg asso
# 9 public ip
# 10 network interface
# 11 vm (1)

# 1 Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# 2 Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# 3 resource group
resource "azurerm_resource_group" "test" {
  name     = "alan_ahmad-rg"
  location = "West Europe"
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Tier   = "Personal"
    Usage  = "Training / Certification related activities"
  }
}

# 4 virtual network
resource "azurerm_virtual_network" "test" {
  name                = "test-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.5.0.0/16"]
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 5 subnet
resource "azurerm_subnet" "test" {
  name                 = "test-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.5.1.0/24"]
}

# 6 network security group
resource "azurerm_network_security_group" "test" {
  name                = "test-nsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 7 network security rule
resource "azurerm_network_security_rule" "test" {
  name                        = "test-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.test.name
}

resource "azurerm_network_security_rule" "test2" {
  name                        = "test2-rule"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.test.name
}

# 8 network subnet nsg asso
resource "azurerm_subnet_network_security_group_association" "test" {
  subnet_id                 = azurerm_subnet.test.id
  network_security_group_id = azurerm_network_security_group.test.id
}

# 9 public ip
resource "azurerm_public_ip" "test" {
  name                = "test-pip"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  allocation_method   = "Static"
  domain_name_label   = "testpetclinic"
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 10 network interface
resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.test.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test.id
  }
}

# 11 vm
resource "azurerm_linux_virtual_machine" "test" {
  name                  = "testing-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  size                  = "Standard_D2s_v3"
  disable_password_authentication = false
  admin_username        = "adminuser"
  admin_password        = "P@assword1234."  # Set your desired password here
  network_interface_ids = [azurerm_network_interface.test.id]
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }

  os_disk {
    name                 = "testOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202209200"
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "test" {
  virtual_machine_id = azurerm_linux_virtual_machine.test.id
  location           = azurerm_resource_group.test.location
  enabled            = true
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }

  daily_recurrence_time = "1900"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled = false

  }
}



# # 4 virtual network
resource "azurerm_virtual_network" "accept" {
  name                = "accept-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.6.0.0/16"]
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 5 subnet
resource "azurerm_subnet" "accept" {
  name                 = "accept-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.accept.name
  address_prefixes     = ["10.6.0.0/24"]
}

# 6 network security group
resource "azurerm_network_security_group" "accept" {
  name                = "accept-nsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 7 network security rule
resource "azurerm_network_security_rule" "accept" {
  name                        = "accept-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.accept.name
}

resource "azurerm_network_security_rule" "accept2" {
  name                        = "accept2-rule"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.accept.name
}

# 8 network subnet nsg asso
resource "azurerm_subnet_network_security_group_association" "accept" {
  subnet_id                 = azurerm_subnet.accept.id
  network_security_group_id = azurerm_network_security_group.accept.id
}

# 9 public ip
resource "azurerm_public_ip" "accept" {
  name                = "accept-pip"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  allocation_method   = "Static"
  domain_name_label   = "xptpetclinic"
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 10 network interface
resource "azurerm_network_interface" "accept" {
  name                = "accept-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.accept.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.accept.id
  }
}

# 11 vm
resource "azurerm_linux_virtual_machine" "accept" {
  name                  = "accept-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  size                  = "Standard_D2s_v3"
  disable_password_authentication = false
  admin_username        = "adminuser"
  admin_password        = "P@assword1234."  # Set your desired password here
  network_interface_ids = [azurerm_network_interface.accept.id]
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }

  os_disk {
    name                 = "acceptOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202209200"
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "accept" {
  virtual_machine_id = azurerm_linux_virtual_machine.accept.id
  location           = azurerm_resource_group.test.location
  enabled            = true
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }


  daily_recurrence_time = "1900"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled = false

  }
}

# # 4 virtual network
resource "azurerm_virtual_network" "production" {
  name                = "production-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.7.0.0/16"]
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 5 subnet
resource "azurerm_subnet" "production" {
  name                 = "production-subnet"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.production.name
  address_prefixes     = ["10.7.0.0/24"]
}

# 6 network security group
resource "azurerm_network_security_group" "production" {
  name                = "production-nsg"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 7 network security rule
resource "azurerm_network_security_rule" "production" {
  name                        = "production-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.production.name
}

resource "azurerm_network_security_rule" "production2" {
  name                        = "production2-rule"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.test.name
  network_security_group_name = azurerm_network_security_group.production.name
}

# 8 network subnet nsg asso
resource "azurerm_subnet_network_security_group_association" "production" {
  subnet_id                 = azurerm_subnet.production.id
  network_security_group_id = azurerm_network_security_group.production.id
}

# 9 public ip
resource "azurerm_public_ip" "production" {
  name                = "production-pip"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
  allocation_method   = "Static"
  domain_name_label   = "prodpetclinic"
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }
}

# 10 network interface
resource "azurerm_network_interface" "production" {
  name                = "production-nic"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.production.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.production.id
  }
}

# 11 vm
resource "azurerm_linux_virtual_machine" "production" {
  name                  = "production-vm"
  resource_group_name   = azurerm_resource_group.test.name
  location              = azurerm_resource_group.test.location
  size                  = "Standard_D2s_v3"
  disable_password_authentication = false
  admin_username        = "adminuser"
  admin_password        = "P@assword1234."  # Set your desired password here
  network_interface_ids = [azurerm_network_interface.production.id]
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }

  os_disk {
    name                 = "productionOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202209200"
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "production" {
  virtual_machine_id = azurerm_linux_virtual_machine.production.id
  location           = azurerm_resource_group.test.location
  enabled            = true
  tags = {
    Pillar = "M Cloud"
    Role   = "Futures"
    Usage  = "Training / Certification related activities"
  }


  daily_recurrence_time = "1900"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled = false

  }
}
