@description('The location in which to create the Log Analytics workspace.')
param location string = resourceGroup().location

@description('The name of the Log Analytics workspace.')
param peName string = 'pe-$(uniqueString(resourceGroup().id))'

@description('The subnet id to connect the private endpoint to.')
param peSubnetId string

@description('The id of the private link service to connect to.')
param plsId string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-02-01' = {
  name: peName
  location: location
  properties: {
    customNetworkInterfaceName: '${peName}-nic'
    privateLinkServiceConnections: [
      {
        name: peName
        properties: {
          groupIds: [ 'azuremonitor' ]
          privateLinkServiceId: plsId
        }
      }
    ]
    subnet: { id: peSubnetId }
  }
}

output name string = privateEndpoint.name