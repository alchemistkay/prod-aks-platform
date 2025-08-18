resource "helm_release" "external_secrets" {
  name             = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = true
  version          = "0.18.2"

  set = [{
    name  = "installCRDs"
    value = "true"
  }]
}

# Create a User-Assigned Managed Identity (UAMI)
resource "azurerm_user_assigned_identity" "external_secrets" {
  name                = "external-secrets-uami"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Assign Key Vault Secrets User to the UAMI.
resource "azurerm_role_assignment" "kv_access" {
  principal_id         = azurerm_user_assigned_identity.external_secrets.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = var.keyvault_id
}

# Create Federated Identity Credential
# This connects the UAMI to a Kubernetes ServiceAccount.
resource "azurerm_federated_identity_credential" "external_secrets" {
  name                = "external-secrets-fic"
  resource_group_name = var.resource_group_name
  parent_id           = azurerm_user_assigned_identity.external_secrets.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.oidc_issuer_url
  subject             = "system:serviceaccount:external-secrets:external-secrets-sa"
}

# Create the Kubernetes ServiceAccount
resource "kubernetes_service_account" "external_secrets" {
  metadata {
    name      = "external-secrets-sa"
    namespace = "external-secrets"
    annotations = {
      "azure.workload.identity/client-id" = azurerm_user_assigned_identity.external_secrets.client_id
    }
  }

  depends_on = [helm_release.external_secrets]
}

# azure secret store uses Workload Identity 
resource "kubernetes_manifest" "azure_secret_store" {
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "azure-kv-store"
    }
    spec = {
      provider = {
        azurekv = {
          tenantId   = var.tenant_id
          vaultUrl   = var.vault_uri
          authType   = "WorkloadIdentity"
          serviceAccountRef = {
            name      = "external-secrets-sa"
            namespace = "external-secrets"
          }
        }
      }
    }
  }

  depends_on = [kubernetes_service_account.external_secrets]
}

