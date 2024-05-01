#!/usr/bin/env bash

# Update: Resources may be created by terraform or manually. (Un)comment whichever you prefer.

# The exisiting resource group will be used 

# Create app service plan

#az appservice plan create \
#      -g Azuredevops \
#      -n udacity-azure-cicd-asp \
#      --is-linux \
#      --sku B1


# CREATE RESOURCES USING TERRAFORM
terraform init
terraform plan -out solution.plan
terraform apply "solution.plan"

# DEPLOY APP
az webapp up \
      -n udacity-azure-cicd-appservice \
      -l westeurope \
      --sku B1 \
