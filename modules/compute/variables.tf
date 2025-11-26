variable "vms" {
  description = "Map of VMs to be created"
  type = map(object({
    vm_name        = string
    location       = string
    rg_name        = string
    subnet_id      = string
    ssh_key        = string
    size           = string
    admin_username = string
    os_disk_type   = string
    tags           = map(string)

    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}
