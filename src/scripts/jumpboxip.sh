GROUPNAME=$(az group list --query "[].name" --output tsv)

JUMPBOXIP=$(az vm list-ip-addresses \
  --resource-group $GROUPNAME \
  --name retailappvmjumpbox \
  --query "[].virtualMachine.network.publicIpAddresses[].ipAddress" \
  --output tsv)

echo $JUMPBOXIP