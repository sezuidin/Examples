@description('The location in which to create the Log Analytics workspace.')
param lawLocation string = resourceGroup().location

@description('The name of the Log Analytics workspace.')
param lawName string

@allowed([
  'Free'
  'PerNode'
  'PerGB2018'
])
@description('The SKU of the Log Analytics workspace. This can be Free, PerNode or PerGB2018.')
param lawSku string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: lawName
  location: lawLocation
  properties: {
    sku: {
      name: lawSku
    }
  }
}