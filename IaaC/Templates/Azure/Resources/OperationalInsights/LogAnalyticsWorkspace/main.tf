
resource "azurerm_log_analytics_workspace" "logAnalyticsWorkspace" {
  internet_ingestion_enabled = var.publicNetworkAccessForIngestion
  internet_query_enabled     = var.publicNetworkAccessForQuery
  location                   = var.location
  name                       = var.name
  sku                        = var.sku
  resource_group_name        = var.resourceGroupName
}