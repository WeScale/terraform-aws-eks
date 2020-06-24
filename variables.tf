variable "name" {
  type        = string
  description = "Cluster Name"
}
variable "security_group_ids" {
  type = list(string)
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
  description = "(optional) describe your variable"
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
  description = "Kubernetes Version"

  default = []
}


variable "endpoint_private_access" {
  type        = bool
  default     = false
  description = "enabled endpoint private access"
}

variable "endpoint_public_access" {
  type        = bool
  default     = true
  description = "enabled describe your variable"
}

variable "public_access_cidrs" {
  type        = list(string)
  default     = []
  description = ""
}

variable "cluster_vars" {
  type        = list(map(string))
  description = "Variables required to build cluster"
  default =[]
}
variable "ami_type" {
  type        = string
  description = "AMI Type"
  default     = "AL2_x86_64"
}
variable "force_update_version" {
  type        = bool
  description = "(optional) describe your variable"
  default     = false
}
variable "instance_types" {
  type        = list(string)
  description = "instance types"
  default     = ["t3.medium"]
}
variable "labels" {
  type        = list(map(string))
  description = "(optional) describe your variable"
  default= []
}
variable "tags_for_node_groups" {
  type        = list(map(string))
  description = "Tags for cluster"
  default     = []
}
variable "depends_cluster" {
  type        = list(list(map(string)))
  description = "dependencies of node groupe"
  default =[]
}
variable "disk_size" {
  type = string
  description = "(optional) describe your variable"
  default = 20

}
variable "create" {
  type = bool
  description = "(optional) describe your variable"
  default = true
}
variable "enabled" {
  type = number
  default = 0
}