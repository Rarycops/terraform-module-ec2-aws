output "placement_group_arn" {
  description = "Amazon Resource Name (ARN) of the placement group."
  value       = var.placement_group_name != null && var.placement_group_strategy != null ? aws_placement_group.placement_group.arn : "placement_group_not deployed"
}

output "placement_group_name" {
  description = "The name of the placement group."
  value       = var.placement_group_name != null && var.placement_group_strategy != null ? aws_placement_group.placement_group.id : "placement_group_not deployed"
}

output "placement_group_id" {
  description = "The ID of the placement group."
  value       = var.placement_group_name != null && var.placement_group_strategy != null ? aws_placement_group.placement_group.placement_group_id : "placement_group_not deployed"
}

output "instance_arn" {
  description = "ARN of the instance."
  value       = aws_instance.instance.arn
}

output "instance_capacity_reservation_specification" {
  description = "Capacity reservation specification of the instance."
  value       = aws_instance.instance.capacity_reservation_specification
}

output "instance_id" {
  description = "ID of the instance."
  value       = aws_instance.instance.id
}

output "instance_outpost_arn" {
  description = "ARN of the Outpost the instance is assigned to."
  value       = aws_instance.instance.outpost_arn
}

output "instance_primary_network_interface_id" {
  description = "ID of the instance's primary network interface."
  value       = aws_instance.instance.primary_network_interface_id
}

output "instance_private_dns" {
  description = "Private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC."
  value       = aws_instance.instance.private_dns
}

output "instance_public_dns" {
  description = "Public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC."
  value       = aws_instance.instance.public_dns
}

output "instance_public_ip" {
  description = "Public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use public_ip as this field will change after the EIP is attached."
  value       = aws_instance.instance.public_ip
}

output "instance_ebs_block_device" {
  description = "ebs_block_device"
  value       = try(aws_instance.instance.ebs_block_device, "ebs_block_device not set")
}

output "instance_instance_market_options" {
  description = "instance_market_options"
  value       = try(aws_instance.instance.instance_market_options, "ebs_block_device not set")
}
