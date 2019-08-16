# Script to reconfigure the lab environment and intriduce problems that the student diagnoses and corrects.

GROUPNAME=$(az group list --query "[].name" --output tsv)

JUMPBOXIP=$(az vm list-ip-addresses \
  --resource-group $GROUPNAME \
  --name retailappvmjumpbox \
  --query "[].virtualMachine.network.publicIpAddresses[].ipAddress" \
  --output tsv)

LOADBALANCERIP=$(az network public-ip show \
  --resource-group $GROUPNAME \
  --name retailappip \
  --query "ipAddress" \
  --output tsv)

# POINT HEALTH PROBE AT PORT 85 IN BACKEND POOL
az network lb probe update \
  --resource-group $GROUPNAME \
  --lb-name retailapplb \
  --name retailapphealthprobe \
  --protocol Tcp \
  --port 85

# STOP retailappvm2
az vm stop \
  --resource-group $GROUPNAME \
  --name retailappvm2

# SET NSG FOR SUBNET WITH PORT 80 MISSING
az network nsg rule delete \
  --resource-group $GROUPNAME \
  --name retailappvnetnsgrule \
  --nsg-name retailappnsg

# SET NSG FOR retailappvm2 WITH DENY ALL
az network nsg rule create \
  --resource-group $GROUPNAME \
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

