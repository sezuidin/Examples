@description('The name of the Private Link Scope.')
param plsName string = 'pls-${uniqueString(resourceGroup().id)}'

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

resource privateLinkScope 'microsoft.insights/privateLinkScopes@2021-07-01-preview' = {
  name: plsName
  location: 'global'
  properties: {
    accessModeSettings: {
      ingestionAccessMode: plsIngestionAccessMode
      queryAccessMode: plsQueryAccessMode
    }
  }
}

output id string = privateLinkScope.id
output name string = privateLinkScope.name