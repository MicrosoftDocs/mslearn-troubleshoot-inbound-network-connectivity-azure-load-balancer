JUMPBOXIP=$(az vm list-ip-addresses \
  --resource-group $RESOURCEGROUP \
  --name retailappvmjumpbox \
  --query "[].virtualMachine.network.publicIpAddresses[].ipAddress" \
  --output tsv)

echo $JUMPBOXIP
