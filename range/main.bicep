
// Setting target scope
targetScope = 'subscription'

// ======== Incoming parameters =========

// Environment prefix
@allowed([
  'ts'
  'pr'
  'dv'
  'dt'
])
param environment string

@minLength(1)
param location string

// Franchisee name
@maxLength(12)
@minLength(2)
param franchisee string

param location_shortname string

// Create/get integration resource group
resource managementrg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-edg-${franchisee}-management-${environment}-${location_shortname}'
  location: location
}

// User assigned managed identity used by Deploy script
module managedidentity 'managedidentity.bicep' = {
  name: 'CreateManagedIdentity'
  scope: managementrg
  params: {
    identityName: 'mi-edg-${franchisee}-automation-${environment}-${location_shortname}'
    location: location
  }
}


