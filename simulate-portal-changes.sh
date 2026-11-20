#!/usr/bin/env bash
# Makes the out-of-band changes from the video, as someone would in the
# Azure portal: soft-delete retention 7 -> 30 days, anonymous blob access on,
# and an incident tag. Run it after the first terraform apply.
set -euo pipefail

rg="rg-brezyweather-forecast-drift"
sa="$(terraform output -raw storage_account_name)"

az storage account blob-service-properties update --resource-group "$rg" --account-name "$sa" \
  --enable-delete-retention true --delete-retention-days 30 --output none
az storage account update --resource-group "$rg" --name "$sa" \
  --allow-blob-public-access true --set tags.incident=INC-4821 --output none

echo "Changed $sa outside Terraform."
