output "id" {
  description = "AKS cluster resource ID."
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "Cluster name."
  value       = azurerm_kubernetes_cluster.this.name
}

output "kube_config_raw" {
  description = "Raw kubeconfig (sensitive)."
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "aks_cluster" {
  description = "AKS cluster resource object (non-sensitive)."
  value       = azurerm_kubernetes_cluster.this
}
