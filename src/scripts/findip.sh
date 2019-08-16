GROUPNAME=$(az group list --query "[].name" --output tsv)

LOADBALANCERIP=$(az network public-ip show \
  --resource-group $GROUPNAME \
  --name retailappip \
  --query "ipAddress" \
  --output tsv)

echo $LOADBALANCERIP
