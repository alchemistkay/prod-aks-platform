resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "systempool"
    vm_size             = var.system_node_vm_size
    node_count          = var.system_node_count
    vnet_subnet_id      = var.aks_subnet_id
    orchestrator_version = var.kubernetes_version
    type                = "VirtualMachineScaleSets"
    auto_scaling_enabled = true
    min_count           = var.system_node_min_count
    max_count           = var.system_node_max_count

    node_labels = {
      "nodepool-type" = "system"
    }
    
    tags                = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = true
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    outbound_type      = "userDefinedRouting" #  using Azure Firewall
    load_balancer_sku  = "standard"
  }

  oidc_issuer_enabled = true
  workload_identity_enabled = true
  private_cluster_enabled = var.enable_private_cluster
  

  tags = var.tags
}

# user node pool
resource "azurerm_kubernetes_cluster_node_pool" "userpool" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = var.user_node_vm_size
  node_count            = var.user_node_count
  vnet_subnet_id        = var.aks_subnet_id
  mode                  = "User"
  auto_scaling_enabled   = true
  min_count             = var.user_node_min_count
  max_count             = var.user_node_max_count
  orchestrator_version  = var.kubernetes_version
  tags                  = var.tags
}

# spot node pool
resource "azurerm_kubernetes_cluster_node_pool" "spotpool" {
  name                  = "spotpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = var.spot_node_vm_size
  node_count            = var.spot_node_count
  vnet_subnet_id        = var.aks_subnet_id
  mode                  = "User"
  auto_scaling_enabled   = true
  min_count             = var.spot_node_min_count
  max_count             = var.spot_node_max_count
  orchestrator_version  = var.kubernetes_version
  priority              = "Spot"
  eviction_policy       = "Delete"
  spot_max_price        = var.spot_max_price

  node_labels = {
    "workload-type" = "spot"
  }

  node_taints = [
    "spot=true:NoSchedule"
  ]

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.main]
}

