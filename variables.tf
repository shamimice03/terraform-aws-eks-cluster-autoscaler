variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the EKS cluster OIDC provider"
  type        = string
}

variable "irsa_role_name" {
  description = "Name of the irsa role"
  type        = string
  default     = ""
}

variable "serviceaccount" {
  description = "Existing service account name"
  type        = string
  default     = ""
}

variable "enable_cluster_autoscaler" {
  description = "Determine cluster autoscaler installation"
  type        = bool
  default     = false
}

variable "role_policies" {
  description = "Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format"
  type        = map(string)
  default     = {}
}

variable "chart_name" {
  type        = string
  default     = null
  description = "Name of the Helm Chart"
}

variable "release_name" {
  type        = string
  default     = null
  description = "Helm Chart release name"
}


variable "chart_version" {
  type        = string
  default     = ""
  description = "Cluster Autoscaler Helm chart version."
}

variable "chart_repo" {
  type        = string
  default     = null
  description = "Cluster Autoscaler repository name."
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Whether to create Kubernetes namespace with name defined by `namespace`."
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Kubernetes namespace to deploy Cluster Autoscaler Helm chart."
}

variable "set" {
  description = "Value block with custom values to be merged with the values yaml"
  type        = any
  default     = []
}

variable "set_annotations" {
  description = "Value annotations name where IRSA role ARN created by module will be assigned to the `value`"
  type        = list(string)
  default     = []
}