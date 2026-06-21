#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE=${1:-infra/yaml/infra.dev.yaml}

if ! command -v yq >/dev/null 2>&1; then
  echo "yq is required for YAML mode. Install mikefarah/yq or use Bicep/Terraform mode."
  exit 1
fi

LOCATION=$(yq '.location' "$CONFIG_FILE")
RG=$(yq '.resourceGroupName' "$CONFIG_FILE")
PREFIX=$(yq '.namePrefix' "$CONFIG_FILE")
ADMIN=$(yq '.adminUsername' "$CONFIG_FILE")
VM_SIZE=$(yq '.vmSize' "$CONFIG_FILE")
SSH_PUBLIC_KEY=${VM_SSH_PUBLIC_KEY:?VM_SSH_PUBLIC_KEY secret is required}

az group create --name "$RG" --location "$LOCATION"
az network vnet create -g "$RG" -n "${PREFIX}-vnet" --address-prefix 10.20.0.0/16 --subnet-name "${PREFIX}-subnet" --subnet-prefixes 10.20.1.0/24
az network nsg create -g "$RG" -n "${PREFIX}-nsg"
az network nsg rule create -g "$RG" --nsg-name "${PREFIX}-nsg" -n Allow-SSH --priority 1000 --destination-port-ranges 22 --access Allow --protocol Tcp
az network nsg rule create -g "$RG" --nsg-name "${PREFIX}-nsg" -n Allow-FastAPI-8000 --priority 1010 --destination-port-ranges 8000 --access Allow --protocol Tcp
az network public-ip create -g "$RG" -n "${PREFIX}-pip"
az network nic create -g "$RG" -n "${PREFIX}-nic" --vnet-name "${PREFIX}-vnet" --subnet "${PREFIX}-subnet" --public-ip-address "${PREFIX}-pip" --network-security-group "${PREFIX}-nsg"
az vm create -g "$RG" -n "${PREFIX}-vm" --nics "${PREFIX}-nic" --image Ubuntu2204 --size "$VM_SIZE" --admin-username "$ADMIN" --ssh-key-values "$SSH_PUBLIC_KEY"
az storage account create -g "$RG" -n "$(echo ${PREFIX}stg | tr -d '-' | tr '[:upper:]' '[:lower:]' | cut -c1-24)" -l "$LOCATION" --sku Standard_LRS --kind StorageV2 --hns true
az datafactory create -g "$RG" -n "${PREFIX}-adf" -l "$LOCATION"
