# BrezyWeather Forecast Storage: Terraform Drift

Demo repository for the Code with Praveen video "Fix Terraform Drift with an AI Agent". A Terraform storage account on Azure, a script that changes it the way someone would in the portal, and Claude Code rules that allow `terraform plan`, ask before `terraform apply`, and deny `terraform destroy` and reads of the state and plan files.

## Requirements

- Terraform 1.15 or later (tested on 1.15.3 with azurerm 5.14.0)
- Azure CLI 2.89.0 or later, signed in (`az login`); Terraform uses its default subscription, which must be one where Azure Policy doesn't deny anonymous blob access (a personal subscription works)
- Claude Code 2.1.327 or later, signed in
- Tested on macOS; an empty Standard_LRS storage account costs close to nothing

## Setup

```bash
git clone https://github.com/CodeWithPraveen/yt-brezyweather-forecast-tf-drift && cd yt-brezyweather-forecast-tf-drift
terraform init
terraform apply                 # creates rg-brezyweather-forecast-drift and one storage account in eastus2; type yes
./simulate-portal-changes.sh    # the portal changes: soft-delete retention 30 days, anonymous blob access on, incident tag
claude                          # pick "Yes, I trust this folder"; the allow rules apply only after that
```

## Tear down

```bash
terraform destroy               # run it yourself (the deny rule blocks Claude); type yes
```
