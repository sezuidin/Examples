@description('One or more zone names for which a virtual network link needs to be created.')
param privateDnsZones array

@description('The virtual network id to connect the virtual network link to.')
param virtualNetworkId string

var randomString = uniqueString(resourceGroup().id)

resource virtualNetworkLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = [for zone in privateDnsZones: {
  location: 'global'
  name: '${zone}/${randomString}'
  properties: {
    registrationEnabled: false
    virtualNetwork: { id: virtualNetworkId }
  }
}]