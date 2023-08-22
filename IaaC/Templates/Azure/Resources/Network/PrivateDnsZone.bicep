@description('One or more zone names for the private DNS zone(s) to create.')
param privateDnsZones array

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = [for zone in privateDnsZones: {
  location: 'global'
  name: zone
}]