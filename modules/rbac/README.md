# RBAC Module for Kubernetes (Terraform)

This module manages Kubernetes Role-Based Access Control (RBAC) resources using Terraform. It supports both **cluster-wide** and **namespace-scoped** permissions for different teams, services, or environments.

## Features

* Create and bind **ClusterRoles** or use existing ones (like `cluster-admin`)
* Create and bind **Roles** within a specific namespace
* Works with **Azure AD groups**, **service accounts**, or **user identities**
* Supports usage in **CI/CD pipelines**, **DevOps teams**, **Platform teams**, etc.

---

## Usage

### 1.Bind Azure AD Group to Built-in `cluster-admin` Role

Grant full admin access to the `devops-team` AAD group:

```hcl
module "devops_admin_rbac" {
  source              = "./modules/rbac"
  scope               = "cluster"
  role_name           = "devops-admin-binding"
  cluster_role_name   = "cluster-admin"
  subject_kind        = "Group"
  subject_name        = "aad-group-object-id"
}
```

---

### 2.Grant Namespace Read-Only Access to CI/CD Service Account

```hcl
module "cicd_readonly_rbac" {
  source        = "./modules/rbac"
  scope         = "namespace"
  namespace     = "dev"
  role_name     = "cicd-readonly"
  api_groups    = [""]
  resources     = ["pods", "services", "configmaps"]
  verbs         = ["get", "list", "watch"]
  subject_kind  = "ServiceAccount"
  subject_name  = "cicd-sa"
}
```

---

### 3.Create Custom ClusterRole for Platform Team

```hcl
module "platform_team_rbac" {
  source        = "./modules/rbac"
  scope         = "cluster"
  role_name     = "platform-read-access"
  api_groups    = ["apps", "networking.k8s.io"]
  resources     = ["deployments", "ingresses"]
  verbs         = ["get", "list"]
  subject_kind  = "Group"
  subject_name  = "aad-platform-team-object-id"
}
```

---

## Inputs

| Name                | Description                                                 | Type   | Default | Required |
| ------------------- | ----------------------------------------------------------- | ------ | ------- | -------- |
| `scope`             | Scope of RBAC (`cluster` or `namespace`)                    | string | n/a     | ✅        |
| `namespace`         | Namespace for Role/Binding (required if scope is namespace) | string | null    | ❌        |
| `role_name`         | Name of the Role or ClusterRole/Binding                     | string | n/a     | ✅        |
| `cluster_role_name` | Existing ClusterRole to bind to instead of creating one     | string | null    | ❌        |
| `api_groups`        | API groups to target (ignored if using `cluster_role_name`) | list   | \[]     | ❌        |
| `resources`         | Resources to access (ignored if using `cluster_role_name`)  | list   | \[]     | ❌        |
| `verbs`             | Verbs like get, list, watch, etc.                           | list   | \[]     | ❌        |
| `subject_kind`      | Type of subject (e.g., `Group`, `User`, `ServiceAccount`)   | string | n/a     | ✅        |
| `subject_name`      | Name of the group/user/SA to bind                           | string | n/a     | ✅        |

---

## Tips

* Use `cluster_role_name` to reference built-in ClusterRoles like `view`, `edit`, `cluster-admin`
* Set `scope = "namespace"` for project-specific or team-isolated access
* Use Terraform locals to manage reusable role sets

---

## Output

> No outputs defined yet — RBAC resources are typically declarative.

---

## Requirements

* Kubernetes provider (Terraform)
* Kubeconfig or AKS context must be available
* RBAC must be enabled in the cluster (default for AKS)

---

## Example AAD Group Object ID

Use Azure CLI to get an Azure AD group object ID:

```bash
az ad group show --group "devops-team" --query objectId -o tsv
```

---

## License

MIT

