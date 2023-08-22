variable "location" {
  default     = "westeurope"
  description = "The location in which to create the Log Analytics workspace."
  type        = string
}

variable "name" {
  default     = "GEN-UNIQUE"
  description = "The name of the Log Analytics workspace."
  type        = string
}

variable "resourceGroupName" {
  description = "The name of the resource group in which the resource needs to be created."
  type        = string
}

variable "publicNetworkAccessForIngestion" {
  description = "Public network access to the Log Analytics workspace for ingestion. This can be Enabled or Disabled."
  type        = bool
  validation {
    condition     = contains(["false", "true"], var.publicNetworkAccessForIngestion)
    error_message = "Provide either true or false as a value for (dis)allowing public network access for ingesting data."
  }
}

variable "publicNetworkAccessForQuery" {
  description = "Public network access to the Log Analytics workspace for query. This can be Enabled or Disabled."
  type        = bool
  validation {
    condition     = contains(["false", "true"], var.publicNetworkAccessForQuery)
    error_message = "Provide either true or false as a value for (dis)allowing public network access to query data."
  }
}

variable "sku" {
  default     = "Free"
  description = "The SKU of the Log Analytics workspace. This can be Free or PerGB2018."
  type        = string
  validation {
    condition     = contains(["Free", "PerGB2018"], var.sku)
    error_message = "Provide either Free or PerGB2018 as a value for the Log Analytics workspace sku."
  }
}