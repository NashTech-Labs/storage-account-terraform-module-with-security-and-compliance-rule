variable "resource_group" {
  type        = string
  description = "Specifies the resourcegroup in which to create the storage account"
  default     = "blob_storage_rg"
}
variable "location" {
  type        = string
  description = "Specifies the region in which to create the blob"
  default     = "eastus"
}
variable "storagename" {
  type        = string
  description = "Specifies the storage account in which to create the storage container."
  default     = "ste"
}
variable "tier" {
  type        = string
  description = "Specifies the type of storage account tier."
  default     = "Standard"
}
variable "accountreplicationtype" {
  type        = string
  description = "Specifies the type of account replication ."
  default     = "GRS"
}
variable "mintlsversion" {
  type        = string
  description = "Specifies the min tls version."
  default     = "TLS1_2"
}
variable "microsoftmanaged" {
  type        = string
  description = "Specifies the name of microsoft managed storage encryption scope."
  default     = "microsoftmanaged"
}
variable "stgsource" {
  type        = string
  description = "Specifies the storage account in which to create the storage container."
  default     = "Microsoft.Storage"
}

# variable "tags" {
#   type = map(any)
#   }


# variable "virtual_network_subnet_ids" {
#   type = string
#   default = "dtrdfgxf"
# }
variable "container_names" {
  type = list(string)
  default = [
    "container11",
    "container22",
    "container33",
  ]
}

