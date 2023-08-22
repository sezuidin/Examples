@description('The location in which to create the Log Analytics workspace.')
param location string = resourceGroup().location

@description('The name of the Log Analytics workspace.')
param name string = 'law-$(uniqueString(resourceGroup().id))'

@allowed([
  'Disabled'
  'Enabled'
])
@description('Public network access to the Log Analytics workspace for ingestion. This can be Enabled or Disabled.')
param publicNetworkAccessForIngestion string

@allowed([
  'Disabled'
  'Enabled'
])
@description('Public network access to the Log Analytics workspace for query. This can be Enabled or Disabled.')
param publicNetworkAccessForQuery string

@allowed([
  'Free'
  'PerGB2018'
])
@description('The SKU of the Log Analytics workspace. This can be Free or PerGB2018.')
param sku string = 'Free'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: name
  location: location
  properties: {
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    sku: { name: sku }
  }
}

output id string = logAnalyticsWorkspace.id