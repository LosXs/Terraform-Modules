# Key format: {workload}/{environment}/{module-or-stack}.tfstate
# Example: landingzone/development/terraform.tfstate
#
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-tfstate-prod-001"
#     storage_account_name = "sttfstateprod001"
#     container_name       = "tfstate"
#     key                  = "landingzone/development/terraform.tfstate"
#   }
# }
