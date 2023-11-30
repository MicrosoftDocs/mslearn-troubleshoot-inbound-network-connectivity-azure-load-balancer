# Script to create the load balancer and virtual machines for the MS Learn exercise


az network vnet create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnet \
  --subnet-name retailappsubnet

az network nsg create \
  --resource-group $RESOURCEGROUP \
  --name retailappnsg

az network nsg rule create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetnsgrule \
  --nsg-name retailappnsg \
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix '*' \
  --destination-port-range 80 \
  --access allow \
  --priority 200

az network nsg rule create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetsshrule \
  --nsg-name retailappnsg \
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix '*' \
  --destination-port-range 22 \
  --access allow \
  --priority 300

az network vnet subnet update \
  --resource-group $RESOURCEGROUP \
  --vnet-name retailappvnet \
  --name retailappsubnet \
  --network-security-group retailappnsg

az network public-ip create \
  --resource-group $RESOURCEGROUP \
  --name retailappip \
  --sku Standard \
  --version IPv4

az network lb create \
  --resource-group $RESOURCEGROUP \
  --name retailapplb \
  --sku Standard \
  --public-ip-address retailappip \
  --public-ip-address-allocation Static \
  --frontend-ip-name retailappfrontend \
  --backend-pool-name retailapppool

az network lb probe create \
  --resource-group $RESOURCEGROUP \
  --lb-name retailapplb \
  --name retailapphealthprobe \
  --protocol Tcp \
  --interval 5 \
  --port 80

az network lb rule create \
  --resource-group $RESOURCEGROUP \
  --lb-name retailapplb \
  --name retailapprule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name retailappfrontend \
  --backend-pool-name retailapppool \
  --probe-name retailapphealthprobe

az network nsg create \
  --resource-group $RESOURCEGROUP \
  --name retailappnicvm1nsg

az network nsg rule create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetnsgvm1rule \
  --nsg-name retailappnicvm1nsg\
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix 'VirtualNetwork' \
  --destination-port-range 80 \
  --access allow \
  --priority 200

az network nsg rule create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetvm1sshrule \
  --nsg-name retailappnicvm1nsg\
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix 'VirtualNetwork' \
  --destination-port-range 22 \
  --access allow \
  --priority 100

az network nic create \
  --resource-group $RESOURCEGROUP \
  --name nicvm1 \
  --vnet-name retailappvnet \
  --subnet retailappsubnet \
  --network-security-group retailappnicvm1nsg \
  --lb-name retailapplb \
  --lb-address-pools retailapppool

az network nsg create \
  --resource-group $RESOURCEGROUP \
  --name retailappnicvm2nsg

az network nsg rule create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetnsgvm2rule \
  --nsg-name retailappnicvm2nsg\
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix 'VirtualNetwork' \
  --destination-port-range 80 \
  --access allow \
  --priority 200

az network nsg rule create \
  --resource-group $RESOURCEGROUP \
  --name retailappvnetvm2sshrule \
  --nsg-name retailappnicvm2nsg\
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix 'VirtualNetwork' \
  --destination-port-range 22 \
  --access allow \
  --priority 100

az network nic create \
  --resource-group $RESOURCEGROUP \
  --name nicvm2 \
  --vnet-name retailappvnet \
  --subnet retailappsubnet \
  --network-security-group retailappnicvm2nsg \
  --lb-name retailapplb \
  --lb-address-pools retailapppool

az vm create \
  --resource-group $RESOURCEGROUP \
  --name retailappvm1 \
  --nics nicvm1 \
  --admin-username azureuser \
  --admin-password $PASSWORD \
  --image Ubuntu2204 \
  --public-ip-address "" 

az vm extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --vm-name retailappvm1 \
  --resource-group $RESOURCEGROUP \
  --settings '{"commandToExecute":"apt-get -y update && apt-get -y install nginx && hostname > /var/www/html/index.html"}'

az vm create \
  --resource-group $RESOURCEGROUP \
  --name retailappvm2 \
  --nics nicvm2 \
  --admin-username $USERNAME \
  --admin-password $PASSWORD \
  --image Ubuntu2204 \
  --public-ip-address ""

az vm extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --vm-name retailappvm2 \
  --resource-group $RESOURCEGROUP \
  --settings '{"commandToExecute":"apt-get -y update && apt-get -y install nginx && hostname > /var/www/html/index.html"}'

az vm create \
  --resource-group $RESOURCEGROUP \
  --name retailappvmjumpbox \
  --admin-username $USERNAME \
  --admin-password $PASSWORD \
  --image Ubuntu2204 \
  --vnet-name retailappvnet \
  --subnet retailappsubnet \
  --public-ip-address-allocation static
