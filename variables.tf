variable "namespace_name" {
  description = "Name for the namespace used for VCSIM deployment"
  type        = string
  default     = "vcsim"
}

variable "service_name" {
  description = "Name for the service used for VCSIM deployment"
  type        = string
  default     = "vcsim-service"
}

variable "deployment_name" {
  description = "Name for the deployment used for VCSIM deployment"
  type        = string
  default     = "vcsim-deployment"
}

variable "app_name" {
  description = "Name for the app used for VCSIM deployment"
  type        = string
  default     = "vcsim"
}

variable "image" {
  description = "Image in public Docker registry used for vcsim deployment"
  type        = string
  default     = "vmware/vcsim:latest"
}