variable "name" {
  type        = string
  description = "Cluster Name"
}
variable "security_group_ids" {
  type = list(string)
}
variable "create" {
  type        = bool
  description = "boolean"
  default     = true
}
variable "enabled" {
  type    = number
  default = 0
}
variable "role" {
  type        = string
  description = " ARN of IAM roles "
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch the cluster in"
  type        = list(string)
}
variable "depends" {
  type        = list(map(string))
  description = "dependencies of cluster"
}


variable "tags_for_cluster" {
  type        = map(string)
  description = "Cluster Tags"
  default     = {}
}
variable "version_kube" {
  type        = string
  description = "Kubernetes Version"
  default     = "1.15"
}


variable "enabled_cluster_log" {
  type        = list(string)
  description = "A list of the desired control plane logging to enable. For more information"
  default     = []
}

variable "endpoint_private_access" {
  type        = bool
  default     = false
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false"
}

variable "endpoint_public_access" {
  type        = bool
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true"
}

variable "public_access_cidrs" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0"
}

variable "cluster_vars" {
  type        = list(map(string))
  description = "Variables required to build Node Groupe"
  default     = []
}
variable "force_update_version" {
  type        = bool
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue"
  default     = false
}
variable "instance_types" {
  type        = list(string)
  description = "instance types"
  default     = ["t3.medium"]
}
variable "labels" {
  type        = list(map(string))
  description = "Key-value map of Kubernetes labels"
  default     = []
}
variable "tags_for_node_groups" {
  type        = list(map(string))
  description = "Tags for cluster"
  default     = []
}
variable "depends_cluster" {
  type        = list(list(map(string)))
  description = "dependencies of node groupe"
  default     = []
}
