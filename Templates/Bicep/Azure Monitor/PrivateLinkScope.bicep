@description('The default location for all resources.')
param defaultLocation string = resourceGroup().location

@allowed([
  'Open'
  'PrivateOnly'
])
@description('The access mode for the ingestion endpoint of the private link scope.')
param plsIngestionAccessMode string

@allowed([
  'Open'
  'PrivateOnly'
])
@description('The access mode for the query endpoint of the private link scope.')
param plsQueryAccessMode string

var randomString = uniqueString(resourceGroup().id)
var resourceNameSuffix = '-AMPLS'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: 'VNET${resourceNameSuffix}'
  location: defaultLocation
  properties: {
    addressSpace: {
      addressPrefixes: [ '192.168.0.0/16' ]
    }
    subnets: [
      {
        name: 'Main'
        properties: {
          addressPrefix: '192.168.1.0/24'
        }
      }
    ]
  }
}

resource privateLinkScope 'microsoft.insights/privateLinkScopes@2021-07-01-preview' = {
  name: 'PLS${resourceNameSuffix}'
  location: 'global'
  properties: {
    accessModeSettings: {
      ingestionAccessMode: plsIngestionAccessMode
      queryAccessMode: plsQueryAccessMode
    }
  }
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-02-01' = {
  name: 'PE${resourceNameSuffix}'
  location: defaultLocation
  properties: {
  }
}