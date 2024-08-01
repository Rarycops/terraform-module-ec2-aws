output "iam_role_arn" {
  description = "The arn of the iam role for the lambda"
  value       = var.instance_iam_instance_profile == null ? aws_iam_role.iam_role[0].arn : "role not generated"
}

output "iam_role_id" {
  description = "The id of the iam role for the lambda"
  value       = var.instance_iam_instance_profile == null ? aws_iam_role.iam_role[0].id : "role not generated"
}

output "iam_role_unique_id" {
  description = "The unique_id of the iam role for the lambda"
  value       = var.instance_iam_instance_profile == null ? aws_iam_role.iam_role[0].unique_id : "role not generated"
}

output "iam_policy" {
  description = "The iam policy object"
  value       = var.iam_policies != {} ? var.iam_policies : "policies not generated"
}

output "iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile."
  value       = var.instance_iam_instance_profile != null && var.iam_instance_profile_name == null ? aws_iam_instance_profile.iam_instance_profile[0].arn : "instance profile not generated"
}

output "iam_instance_profile_id" {
  description = "Instance profile's ID."
  value       = var.instance_iam_instance_profile != null && var.iam_instance_profile_name == null ? aws_iam_instance_profile.iam_instance_profile[0].id : "instance profile not generated"
}

output "iam_instance_profile_unique_id" {
  description = "Unique ID assigned by AWS."
  value       = var.instance_iam_instance_profile != null && var.iam_instance_profile_name == null ? aws_iam_instance_profile.iam_instance_profile[0].unique_id : "instance profile not generated"
}
