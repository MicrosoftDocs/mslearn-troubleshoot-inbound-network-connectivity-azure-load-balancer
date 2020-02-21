LOADBALANCERIP=$(az network public-ip show \
  --resource-group $RESOURCEGROUP \
  --name retailappip \
  --query "ipAddress" \
  --output tsv)

echo $LOADBALANCERIP
