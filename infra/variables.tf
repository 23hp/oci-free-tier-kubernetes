variable "compartment_id" {
  type        = string
  description = "The compartment to create the resources in"
}

variable "region" {
  type        = string
  description = "The region to provision the resources in"
}

variable "ssh_public_key" {
  type        = string
  description = "The SSH public key to use for connecting to the worker nodes"
}

variable "k8s_ver" {
  type        = string
  description = "kubernetes_version"
  default     = "v1.27.2"
}

variable "kube_config_path" {
  type = string
}
