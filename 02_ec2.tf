resource "aws_instance" "instance" {
  depends_on = [aws_iam_instance_profile.iam_instance_profile]

  ami                                  = var.instance_ami
  instance_type                        = var.instance_type
  availability_zone                    = var.instance_availability_zone
  key_name                             = var.instance_key_name
  monitoring                           = var.instance_monitoring
  subnet_id                            = var.instance_subnet_id
  vpc_security_group_ids               = var.instance_vpc_security_group_ids
  associate_public_ip_address          = var.instance_associate_public_ip_address
  tags                                 = merge(var.general_tags, var.instance_tags)
  user_data                            = var.instance_user_data
  user_data_base64                     = var.instance_user_data_base64
  iam_instance_profile                 = try(coalesce(var.instance_iam_instance_profile, aws_iam_instance_profile.iam_instance_profile[0].id), null)
  disable_api_termination              = var.instance_disable_api_termination
  disable_api_stop                     = var.instance_disable_api_stop
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  get_password_data                    = var.instance_get_password_data
  hibernation                          = var.instance_hibernation
  ebs_optimized                        = var.instance_ebs_optimized
  host_id                              = var.instance_host_id
  host_resource_group_arn              = var.instance_host_resource_group_arn
  tenancy                              = var.instance_tenancy
  ipv6_address_count                   = var.instance_ipv6_address_count
  ipv6_addresses                       = var.instance_ipv6_address
  placement_group                      = var.instance_placement_group
  placement_partition_number           = var.placement_group_name != null && var.placement_group_strategy != null ? var.instance_placement_partition_number : null
  private_ip                           = var.instance_private_ip
  secondary_private_ips                = var.instancce_secondary_private_ips
  security_groups                      = var.instancce_security_groups
  source_dest_check                    = var.instancce_source_dest_check
  user_data_replace_on_change          = var.instancce_user_data_replace_on_change
  volume_tags                          = merge(var.general_tags, var.instance_volume_tags)
  dynamic "private_dns_name_options" {
    for_each = var.instance_private_dns_name_options_hostname_type != null ? [1] : []
    content {
      enable_resource_name_dns_a_record    = var.instance_private_dns_name_options_enable_resource_name_dns_a_record
      enable_resource_name_dns_aaaa_record = var.instance_private_dns_name_options_enable_resource_name_dns_aaaa_record
      hostname_type                        = var.instance_private_dns_name_options_hostname_type
    }
  }
  dynamic "network_interface" {
    for_each = { for key, value in var.instance_network_interface_map : key => value }
    content {
      delete_on_termination = network_interface.value.delete_on_termination
      device_index          = network_interface.value.device_index
      network_card_index    = network_interface.value.network_card_index
      network_interface_id  = network_interface.value.network_interface_id
    }
  }
  metadata_options {
    http_endpoint               = var.instance_metadata_options_http_endpoint
    http_protocol_ipv6          = var.instance_metadata_options_http_protocol_ipv6
    http_put_response_hop_limit = var.instance_metadata_options_http_put_response_hop_limit
    http_tokens                 = var.instance_metadata_options_http_tokens
    instance_metadata_tags      = var.instance_metadata_options_instance_metadata_tags
  }
  maintenance_options {
    auto_recovery = var.instance_maintenance_options_auto_recovery
  }
  dynamic "instance_market_options" {
    for_each = (
      (var.instance_instance_market_options_spot_options_max_price != null) ||
      (var.instance_instance_market_options_spot_options_valid_until != null)
    ) ? [1] : []
    content {
      market_type = "spot"
      spot_options {
        instance_interruption_behavior = var.instance_instance_market_options_spot_options_instance_interruption_behavior
        max_price                      = var.instance_instance_market_options_spot_options_max_price
        spot_instance_type             = var.instance_instance_market_options_spot_options_spot_instance_type
        valid_until                    = var.instance_instance_market_options_spot_options_valid_until
      }
    }
  }
  enclave_options {
    enabled = var.instances_enclave_options_enabled
  }
  cpu_options {
    amd_sev_snp      = var.instance_cpu_options_amd_sev_snp
    core_count       = var.instance_cpu_options_core_count
    threads_per_core = var.instance_cpu_options_threads_per_core
  }
  capacity_reservation_specification {
    capacity_reservation_preference = var.instance_capacity_reservation_preference
    dynamic "capacity_reservation_target" {
      for_each = var.instance_capacity_reservation_preference != "open" ? [1] : []
      content {
        capacity_reservation_id                 = var.instance_capacity_reservation_target_capacity_reservation_id
        capacity_reservation_resource_group_arn = var.instance_capacity_reservation_target_capacity_reservation_resource_group_arn
      }
    }
  }
  credit_specification {
    cpu_credits = var.instance_cpu_credits
  }
  dynamic "root_block_device" {
    for_each = { for key, value in var.instance_root_block_device_map : key => value }
    content {
      volume_type           = root_block_device.value.volume_type == "value" ? null : root_block_device.value.volume_type
      volume_size           = root_block_device.value.volume_size == 0 ? null : root_block_device.value.volume_size
      delete_on_termination = root_block_device.value.delete_on_termination
      encrypted             = root_block_device.value.encrypted
      iops                  = root_block_device.value.iops == 0 ? null : root_block_device.value.iops
      kms_key_id            = root_block_device.value.kms_key_id == "value" ? null : root_block_device.value.kms_key_id
      tags                  = root_block_device.value.tags == { name : "value" } ? null : root_block_device.value.tags
      throughput            = root_block_device.value.throughput == 0 ? null : root_block_device.value.throughput
    }
  }
  dynamic "ebs_block_device" {
    for_each = { for key, value in var.instance_ebs_block_device_map : key => value }
    content {
      device_name           = ebs_block_device.value.device_name == "value" ? null : ebs_block_device.value.device_name
      volume_type           = ebs_block_device.value.volume_type == "value" ? null : ebs_block_device.value.volume_type
      volume_size           = ebs_block_device.value.volume_size == 0 ? null : ebs_block_device.value.volume_size
      delete_on_termination = ebs_block_device.value.delete_on_termination
      encrypted             = ebs_block_device.value.snapshot_id == "value" ? ebs_block_device.value.encrypted : null
      iops                  = ebs_block_device.value.iops == 0 ? null : ebs_block_device.value.iops
      kms_key_id            = ebs_block_device.value.kms_key_id == "value" ? null : ebs_block_device.value.kms_key_id
      snapshot_id           = ebs_block_device.value.snapshot_id == "value" ? null : ebs_block_device.value.snapshot_id
      tags                  = ebs_block_device.value.tags == { name : "value" } ? null : ebs_block_device.value.tags
      throughput            = ebs_block_device.value.throughput == 0 ? null : ebs_block_device.value.throughput
    }
  }
  dynamic "ephemeral_block_device" {
    for_each = { for key, value in var.instance_ephemeral_map : key => value }
    content {
      device_name  = ephemeral_block_device.value.device_name == "value" ? null : ephemeral_block_device.value.device_name
      no_device    = ephemeral_block_device.value.no_device
      virtual_name = ephemeral_block_device.value.virtual_name == "value" ? null : ephemeral_block_device.value.virtual_name
    }
  }
  dynamic "launch_template" {
    for_each = var.instance_ami == null ? [1] : []
    content {
      name    = var.instance_launch_template_name
      version = var.instance_launch_template_version
    }
  }
}

resource "aws_placement_group" "placement_group" {
  count = var.placement_group_name != null && var.placement_group_strategy != null ? 1 : 0

  name            = var.placement_group_name
  strategy        = var.placement_group_strategy
  spread_level    = var.placement_group_spread_level
  tags            = merge(var.general_tags, var.placement_group_tags)
  partition_count = var.placement_group_count
}
