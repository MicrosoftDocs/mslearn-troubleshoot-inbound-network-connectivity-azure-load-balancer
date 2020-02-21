# Script to reconfigure the lab environment and introduce problems that the student diagnoses and corrects.

# POINT HEALTH PROBE AT PORT 85 IN BACKEND POOL
az network lb probe update \
  --resource-group $RESOURCEGROUP \
  --lb-name retailapplb \
  --name retailapphealthprobe \
  --protocol Tcp \
  --port 85

# STOP retailappvm2
az vm stop \
  --resource-group $RESOURCEGROUP \
  --name retailappvm2

# SET NSG FOR SUBNET WITH PORT 80 MISSING
az network nsg rule delete \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetnsgrule \
  --nsg-name retailappnsg

# SET NSG FOR retailappvm2 WITH DENY ALL
az network nsg rule create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetnsgrulevm2denyall \
  --nsg-name retailappnicvm2nsg \
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix '*' \
  --destination-port-range '*' \
  --access deny \
  --priority 110

