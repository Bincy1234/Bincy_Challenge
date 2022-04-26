variable "instance_type" {
  description = "Type of instance to provision."
  default     = "t2.micro"
}

variable "min_size" {
  description = "The minimum (and desired) size of the auto scale group."
  default     = 1
}

variable "max_size" {
  description = "The maximum size of the auto scale group."
  default     = 3
}
