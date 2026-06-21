using '../bicep/main.bicep'

param location = 'uksouth'
param namePrefix = 'retailintgdev'
param adminUsername = 'azureadmin'
param vmSize = 'Standard_B2s'
param allowedSshCidr = '0.0.0.0/0'
