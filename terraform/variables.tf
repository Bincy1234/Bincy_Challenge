variable "vault_password" {
  type = string
}

variable "certificateID" {
  type        = string
  default     = ""
  description = "The arn of the certificate"
}
