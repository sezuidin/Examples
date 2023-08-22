@description('The name of the private link scope.')
param plsName string

@description('The resource id of the Log Analytics workspace to link to the private link scope.')
param workspaceId string

resource privateLinkScope 'microsoft.insights/privateLinkScopes@2021-07-01-preview' existing = { name: plsName }

resource scopedResource 'Microsoft.Insights/privateLinkScopes/scopedResources@2021-07-01-preview' = {
  name: 'ConnectedWorkspace'
  parent: privateLinkScope
  properties: { linkedResourceId: workspaceId }
}