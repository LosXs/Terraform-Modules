# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial scaffold and v0.1 modules: `_shared/tags`, `_shared/naming`, `governance/resource-group`, `monitoring/log-analytics-workspace`, `monitoring/diagnostic-setting`, examples `single-resource` and started `complete-landing-zone`.
- **Identity & security:** `identity-security/key-vault`, `key-vault-secret`, `role-assignment` with documentation.
- **Networking:** `networking/virtual-network`, `subnet`, `network-security-group`, `route-table` with documentation.
- **Examples:** `complete-landing-zone` extended with VNet, subnet, NSG, subnet–NSG association, and diagnostics to Log Analytics where supported.
- **Governance:** `governance/management-group`, `governance/policy-assignment` (azurerm 4.x `enforce` on resource group policy assignment).
- **Networking:** `networking/private-endpoint`, `networking/private-dns-zone`.
- **Storage:** `storage/storage-account`, `storage/file-share` (share uses `storage_account_id`).
- **Identity:** `identity-security/key-vault-key`, `identity-security/user-assigned-identity`.
- **Monitoring:** `monitoring/action-group`, `monitoring/monitor-alert`.
- **Database:** `database/mssql-server` (`sql_version` variable), `database/mssql-database`, `database/postgresql-flexible-server`, `database/cosmosdb`.
- **Compute:** `compute/virtual-machine`, `compute/virtual-machine-scale-set`, `compute/azure-virtual-desktop`.
- **App services:** `app-services/app-service-plan` (`azurerm_service_plan`), `app-services/linux-web-app`, `app-services/windows-web-app`, `app-services/function-app`.
- **Containers:** `containers/container-registry`, `containers/aks-cluster`, `containers/container-app-environment`, `containers/container-app`, `containers/container-app-job` (manual or schedule triggers, required CPU/memory on job container).
- **Documentation:** `docs/README.md` for each module above; root README module index updated to **Implemented** for all listed paths.

### Changed

- `database/mssql-database`: removed unused `resource_group_name` and `location` variables (not used by `azurerm_mssql_database`).
- `monitoring/monitor-alert`: removed unused `location` variable (`azurerm_monitor_metric_alert` has no location argument).
