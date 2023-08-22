@description('The name of the existing private endpoint that is part of this private link scope.')
param privateEndpointName string

@description('One or more zone names for the private DNS zone group(s) to create.')
param privateDnsZones array

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-02-01' existing = { name: privateEndpointName }

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-02-01' = {
  name: 'default'
  parent: privateEndpoint
  properties: {
    privateDnsZoneConfigs: [for zone in privateDnsZones: {
      name: replace(zone, '.', '-')
      properties: { privateDnsZoneId: resourceId('Microsoft.Network/privateDnsZones', zone) }
    }]
  }
}