variable "vm_name" {
  type = string
}

variable "vm_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_username_pub_key" {
  type = string
}

variable "os_disk_caching" {
  type = string
}

variable "os_disk_storage_account_type" {
  type = string
}

variable "os_disk_size_gb" {
  type = string
}

variable "vm_priority" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "source_image_offer" {
  type = string
}

variable "source_image_publisher" {
  type = string
}

variable "source_image_sku" {
  type = string
}

variable "source_image_version" {
  type = string
}



