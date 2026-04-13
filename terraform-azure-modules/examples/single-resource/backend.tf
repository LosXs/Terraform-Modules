# Key format: {workload}/{environment}/{module-or-stack}.tfstate
# Example: networking/production/terraform.tfstate
#
# Uncomment and replace placeholders after your Azure Storage backend exists.

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-tfstate-prod-001"
#     storage_account_name = "sttfstateprod001"
#     container_name       = "tfstate"
#     key                  = "WORKLOAD/ENVIRONMENT/terraform.tfstate"
#   }
# }
