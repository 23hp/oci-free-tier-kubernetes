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

variable "image_id" {  
  # See https://docs.oracle.com/en-us/iaas/images/
  # choose aarch64 image for oke-worker-node and OKE version matchs
    type        = string
    description = "work node image"
    default     ="ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5kjsb5noexrlvpgcozu4mk2f2vasdh4hlvgmv4jnltgl4xuab3ma"
}

variable "kube_config_path" {
  type = string
}
