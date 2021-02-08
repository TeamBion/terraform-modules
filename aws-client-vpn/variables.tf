variable "name" {
  description = "Name prefix for the resources of this stack"
}

variable "cidr" {
  description = "Network CIDR to use for clients"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ID to associate clients"
}

variable "organization_name" {
  description = "Name of organization to use in private certificate"
  default     = ""
}

variable "tags" {
  type        = map
  default     = {}
  description = "Extra tags to attach to resources"
}

variable "logging_enabled" {
    type = bool
    default = false
    description = "Enable cloudwatch logging for vpn"
}

variable "log_group_name" {
    type = string
    default = "aws-client-vpn"
    description = "Log group name for cloudwatch"
}

variable "logs_retention" {
  default     = 30
  description = "Retention in days for CloudWatch Log Group"
}

variable "target_network_cidrs" {
    type = list(string)
    description = "Target CIDR list for authorisation"
}