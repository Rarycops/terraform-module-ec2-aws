variable "iam_role_tags" {
  description = "Key-value map of tags for the IAM role."
  type        = map(string)
  default     = {}
}

variable "iam_role_assume_role_policy" {
  description = "The policy that grants an entity permission to assume the role. Must be a valid JSON."
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "The name of the role. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "he description of the role."
  type        = string
  default     = null
}

variable "iam_role_force_detach_policies" {
  description = "Specifies to force detaching any policies the role has before destroying it. Defaults to false."
  type        = bool
  default     = false
}

variable "iam_role_path" {
  description = "The path to the role. See IAM Identifiers for more information."
  type        = string
  default     = null
}

variable "iam_role_max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = number
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = null
}

variable "iam_role_policy_attachment_arn" {
  description = "The ARN of the policy you want to apply."
  type        = map(string)
  default     = {}
}

variable "iam_policies" {
  description = "Map for generating policies that are going to be attached to the lambda"
  type = map(object({
    name        = string
    description = string
    path        = string
    policy      = string
    tags        = map(string)
  }))
  default = {}
}

variable "iam_instance_profile_tags" {
  description = "The ARN of the policy you want to apply."
  type        = map(string)
  default     = {}
}

variable "iam_instance_profile_path" {
  description = "Path to the instance profile. For more information about paths, see IAM Identifiers in the IAM User Guide. Can be a string of characters consisting of either a forward slash (/) by itself or a string that must begin and end with forward slashes. Can include any ASCII character from the ! (\u0021) through the DEL character (\u007F), including most punctuation characters, digits, and upper and lowercase letters."
  type        = string
  default     = null
}

variable "iam_instance_profile_name" {
  description = "Name of the instance profile. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix."
  type        = string
  validation {
    condition     = var.iam_instance_profile_name == null || can(regex("^[a-zA-Z0-9_+=,.@-]+$", var.iam_instance_profile_name))
    error_message = "The name can only consist of upper and lowercase alphanumeric characters and these special characters: _, +, =, ,, ., @, -. Spaces are not allowed."
  }
  default = null
}
