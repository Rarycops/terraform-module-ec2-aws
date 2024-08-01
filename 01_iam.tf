# Creation of the lambda role
resource "aws_iam_role" "iam_role" {
  count = var.instance_iam_instance_profile == null ? 1 : 0

  name                  = var.iam_role_name
  description           = var.iam_role_description
  force_detach_policies = var.iam_role_force_detach_policies
  path                  = var.iam_role_path
  max_session_duration  = var.iam_role_max_session_duration
  permissions_boundary  = var.iam_role_permissions_boundary
  assume_role_policy    = var.iam_role_assume_role_policy
  tags                  = merge(var.general_tags, var.iam_role_tags)
}

# Creationn of the policies passed as policy json
resource "aws_iam_policy" "iam_policy" {
  for_each = var.iam_policies

  name        = each.value.name == "value" ? null : each.value.name
  description = each.value.description == "value" ? null : each.value.description
  path        = each.value.path == "value" ? null : each.value.path
  policy      = each.value.policy == "value" ? null : each.value.policy
  tags        = merge(var.general_tags, each.value.tags == { name = "value" } ? {} : each.value.tags)
}

# Attachment of policies passed as arn to the lambda
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_arn" {
  depends_on = [aws_iam_role.iam_role]
  for_each   = var.iam_role_policy_attachment_arn

  policy_arn = each.value
  role       = var.instance_iam_instance_profile != null ? var.instance_iam_instance_profile : aws_iam_role.iam_role[0].arn
}

# Attachment of policies passed as policy json to the lambda
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  depends_on = [
    aws_iam_role.iam_role,
    aws_iam_policy.iam_policy
  ]
  for_each = aws_iam_policy.iam_policy

  policy_arn = each.value.arn
  role       = var.instance_iam_instance_profile != null ? var.instance_iam_instance_profile : aws_iam_role.iam_role[0].arn
}


resource "aws_iam_instance_profile" "iam_instance_profile" {
  count = var.instance_iam_instance_profile != null && var.iam_instance_profile_name != null ? 1 : 0

  name = var.iam_instance_profile_name
  path = var.iam_instance_profile_path
  role = aws_iam_role.iam_role.name
  tags = merge(var.general_tags, var.iam_instance_profile_tags)
}
