@description('Define various settings for the virtual network.')
param vnetSettings object = {
  location: resourceGroup().location
  name: 'vnet-${uniqueString(resourceGroup().id)}'
  addressPrefixes: [ '192.168.0.0/16' ]
  subnets: [
    {
      name: 'Main'
      addressPrefix: '192.168.1.0/24'
    }
  ]
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  location: vnetSettings.location
  name: vnetSettings.name
  properties: {
    addressSpace: {
      addressPrefixes: vnetSettings.addressPrefixes
    }
    subnets: [for subnet in vnetSettings.subnets: {
        name: subnet.name
        properties: { addressPrefix: subnet.addressPrefix }
      }
    ]
  }
}

output id string = virtualNetwork.id
output subnets array = virtualNetwork.properties.subnets