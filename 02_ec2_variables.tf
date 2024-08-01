variable "instance_ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "instance_availability_zone" {
  description = "The availability zone to launch the instance in"
  type        = string
  default     = null
}

variable "instance_key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = null
}

variable "instance_monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = null
}

variable "instance_subnet_id" {
  description = "The VPC subnet ID to launch in"
  type        = string
  default     = null
}

variable "instance_vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "instance_associate_public_ip_address" {
  description = "Associate a public IP address with the instance"
  type        = bool
  default     = true
}

variable "instance_capacity_reservation_preference" {
  description = "Capacity reservation preference"
  type        = string
  default     = "open"
  validation {
    condition     = var.instance_capacity_reservation_preference == "open" || var.instance_capacity_reservation_preference == "none"
    error_message = "The capacity reservation preference must be either 'open' or 'none'."
  }
}

variable "instance_capacity_reservation_target_capacity_reservation_id" {
  description = "Capacity reservation ID"
  type        = string
  default     = null
}

variable "instance_capacity_reservation_target_capacity_reservation_resource_group_arn" {
  description = "Capacity reservation resource group ARN"
  type        = string
  default     = null
}

variable "instance_cpu_credits" {
  description = "The credit option for CPU usage"
  type        = string
  default     = null
}

variable "instance_root_block_device_map" {
  description = "Map for root block device"
  type = map(object({
    volume_type           = string
    volume_size           = number
    delete_on_termination = bool
    encrypted             = bool
    iops                  = number
    kms_key_id            = string
    tags                  = map(string)
    throughput            = number
  }))
  default = {}
}

variable "instance_ebs_block_device_map" {
  description = "Map for ebs block device"
  type = map(object({
    device_name           = string
    volume_type           = string
    volume_size           = number
    delete_on_termination = bool
    encrypted             = bool
    iops                  = number
    kms_key_id            = string
    snapshot_id           = string
    tags                  = map(string)
    throughput            = number
  }))
  default = {}
}

variable "instance_ephemeral_map" {
  description = "Map for ephemeral instances"
  type = map(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
  }))
  default = {}
}

variable "instance_tags" {
  description = "A map of tags to assign to the instance"
  type        = map(string)
  default     = {}
}

variable "instance_user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "instance_user_data_base64" {
  description = "The base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "instance_iam_instance_profile" {
  description = "The IAM instance profile to associate with the instance"
  type        = string
  default     = null
}

variable "instance_disable_api_termination" {
  description = "If true, enables EC2 instance termination protection"
  type        = bool
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  type        = string
  default     = "stop"
}

variable "instance_get_password_data" {
  description = "If true, wait for password data to become available and retrieve it"
  type        = bool
  default     = null
}

variable "instance_hibernation" {
  description = "If true, the instance is hibernated instead of shut down when stopped"
  type        = bool
  default     = null
}

variable "instance_launch_template_name" {
  description = "Name of the launch template."
  type        = string
  default     = null
}

variable "instance_launch_template_version" {
  description = "Template version. Can be a specific version number, $Latest or $Default."
  type        = string
  default     = null
}

variable "instance_cpu_options_amd_sev_snp" {
  description = "Indicates whether to enable the instance for AMD SEV-SNP. AMD SEV-SNP is supported with M6a, R6a, and C6a instance types only."
  type        = string
  validation {
    condition     = var.instance_cpu_options_amd_sev_snp == "disabled" || var.instance_cpu_options_amd_sev_snp == "enabled"
    error_message = "Valid values are enabled and disabled."
  }
  default = "disabled"
}

variable "instance_cpu_options_core_count" {
  description = "Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API."
  type        = number
  default     = null
}

variable "instance_cpu_options_threads_per_core" {
  description = "Has no effect unless core_count is also set) If set to 1, hyperthreading is disabled on the launched instance. Defaults to 2 if not set. See Optimizing CPU Options for more information."
  type        = number
  default     = null
}

variable "instance_disable_api_stop" {
  description = "If true, enables EC2 Instance Stop Protection."
  type        = bool
  default     = null
}

variable "instance_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  type        = bool
  default     = null
}

variable "instances_enclave_options_enabled" {
  description = "Enable Nitro Enclaves on launched instances."
  type        = bool
  default     = false
}

variable "instance_host_id" {
  description = "ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host."
  type        = string
  default     = null
}

variable "instance_host_resource_group_arn" {
  description = "ARN of the host resource group in which to launch the instances. If you specify an ARN, omit the tenancy parameter or set it to host."
  type        = string
  validation {
    condition     = ((var.instance_tenancy == null || var.instance_host_resource_group_arn != null) && var.instance_tenancy == "host") || var.instance_host_resource_group_arn == null
    error_message = "Valid values are default, dedicated, and host."
  }
  default = null
}

variable "instance_tenancy" {
  description = "Tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the import-instance command."
  type        = string
  validation {
    condition     = var.instance_tenancy == "default" || var.instance_tenancy == "dedicated" || var.instance_tenancy == "host" || var.instance_tenancy == null
    error_message = "Valid values are default, dedicated, and host."
  }
  default = null
}

variable "instance_instance_market_options_spot_options_instance_interruption_behavior" {
  description = "he behavior when a Spot Instance is interrupted. Valid values include hibernate, stop, terminate."
  type        = string
  default     = "terminate"
}

variable "instance_instance_market_options_spot_options_max_price" {
  description = "The maximum hourly price that you're willing to pay for a Spot Instance."
  type        = string
  default     = null
}

variable "instance_instance_market_options_spot_options_spot_instance_type" {
  description = "The Spot Instance request type. Persistent Spot Instance requests are only supported when the instance interruption behavior is either hibernate or stop."
  type        = string
  validation {
    condition     = var.instance_instance_market_options_spot_options_spot_instance_type == "persistent" || var.instance_instance_market_options_spot_options_spot_instance_type == "one-time"
    error_message = "Valid values include one-time, persistent."
  }
  default = "one-time"
}

variable "instance_instance_market_options_spot_options_valid_until" {
  description = "The end date of the request, in UTC format (YYYY-MM-DDTHH:MM:SSZ)."
  type        = string
  validation {
    condition     = (var.instance_instance_market_options_spot_options_spot_instance_type == "persistent" && var.instance_instance_market_options_spot_options_valid_until != null) || var.instance_instance_market_options_spot_options_valid_until == null
    error_message = "Supported only for persistent requests."
  }
  default = null
}

variable "instance_ipv6_address_count" {
  description = "Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  type        = number
  default     = null
}

variable "instance_ipv6_address" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface."
  type        = list(string)
  default     = null
}

variable "instance_maintenance_options_auto_recovery" {
  description = "Automatic recovery behavior of the Instance."
  type        = string
  validation {
    condition     = var.instance_maintenance_options_auto_recovery == "default" || var.instance_maintenance_options_auto_recovery == "disabled"
    error_message = "Can be default or disabled."
  }
  default = "default"
}

variable "instance_metadata_options_http_endpoint" {
  description = "Whether the metadata service is available."
  type        = string
  validation {
    condition     = var.instance_metadata_options_http_endpoint == "enabled" || var.instance_metadata_options_http_endpoint == "disabled"
    error_message = "Can be enabled or disabled."
  }
  default = "enabled"
}

variable "instance_metadata_options_http_protocol_ipv6" {
  description = "Whether the IPv6 endpoint for the instance metadata service is enabled."
  type        = string
  default     = "disabled"
}

variable "instance_metadata_options_http_put_response_hop_limit" {
  description = "Desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further instance metadata requests can travel."
  type        = string
  validation {
    condition     = var.instance_metadata_options_http_put_response_hop_limit > 0 && var.instance_metadata_options_http_put_response_hop_limit < 65
    error_message = "Valid values are integer from 1 to 64."
  }
  default = 1
}

variable "instance_metadata_options_http_tokens" {
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2 (IMDSv2)."
  type        = string
  validation {
    condition     = var.instance_metadata_options_http_tokens == "optional" || var.instance_metadata_options_http_tokens == "required"
    error_message = "Can be enabled or disabled."
  }
  default = "optional"
}

variable "instance_metadata_options_instance_metadata_tags" {
  description = "Enables or disables access to instance tags from the instance metadata service."
  type        = string
  validation {
    condition     = var.instance_metadata_options_instance_metadata_tags == "enabled" || var.instance_metadata_options_instance_metadata_tags == "disabled"
    error_message = "Can be enabled or disabled."
  }
  default = "disabled"
}

variable "instance_network_interface_map" {
  description = "Map for network interfaces"
  type = map(object({
    delete_on_termination = bool
    device_index          = number
    network_card_index    = number
    network_interface_id  = string
  }))
  default = {}
}

variable "instance_placement_group" {
  description = "Placement Group to start the instance in."
  type        = string
  default     = null
}

variable "instance_placement_partition_number" {
  description = "Number of the partition the instance is in."
  type        = number
  validation {
    condition     = (var.instance_placement_partition_number != null && (var.placement_group_name != null && var.placement_group_strategy != null)) || var.instance_placement_partition_number == null
    error_message = "Valid only if the aws_placement_group resource's strategy argument is set to partition."
  }
  default = null
}

variable "placement_group_name" {
  description = "The name of the placement group."
  type        = string
  default     = null
}

variable "placement_group_strategy" {
  description = "The placement strategy."
  type        = string
  validation {
    condition     = var.placement_group_strategy == "partition" || var.placement_group_strategy == "cluster" || var.placement_group_strategy == "spread" || var.placement_group_strategy == null
    error_message = "Can be cluster, partition or spread."
  }
  default = null
}

variable "placement_group_spread_level" {
  description = "Determines how placement groups spread instances."
  type        = string
  validation {
    condition     = (var.placement_group_strategy == "spread" && (var.placement_group_spread_level == "host" || var.placement_group_spread_level == "rack")) || var.placement_group_spread_level == "rack"
    error_message = "Can only be used when the strategy is set to spread. Can be host or rack. host can only be used for Outpost placement groups."
  }
  default = "rack"
}

variable "placement_group_tags" {
  description = "Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

variable "placement_group_count" {
  description = "The number of partitions to create in the placement group."
  type        = number
  validation {
    condition     = can(var.placement_group_strategy == "partition" && var.placement_group_count >= 1 && var.placement_group_count <= 7) || var.placement_group_count == null
    error_message = "Can only be specified when the strategy is set to partition. The partition count must be between 1 and 7."
  }
  default = null
}

variable "instance_private_dns_name_options_enable_resource_name_dns_a_record" {
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records."
  type        = bool
  default     = null
}

variable "instance_private_dns_name_options_enable_resource_name_dns_aaaa_record" {
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS A records."
  type        = bool
  default     = null
}

variable "instance_private_dns_name_options_hostname_type" {
  description = "Type of hostname for Amazon EC2 instances. For IPv4 only subnets, an instance DNS name must be based on the instance IPv4 address. For IPv6 native subnets, an instance DNS name must be based on the instance ID. For dual-stack subnets, you can specify whether DNS names use the instance IPv4 address or the instance ID."
  type        = string
  validation {
    condition     = var.instance_private_dns_name_options_hostname_type == "ip-name" || var.instance_private_dns_name_options_hostname_type == "resource-name" || var.instance_private_dns_name_options_hostname_type == null
    error_message = "Valid values: ip-name and resource-name."
  }
  default = null
}

variable "instance_private_ip" {
  description = "Private IP address to associate with the instance in a VPC."
  type        = string
  default     = null
}

variable "instancce_secondary_private_ips" {
  description = "List of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e., referenced in a network_interface block."
  type        = list(string)
  default     = null
}

variable "instancce_security_groups" {
  description = "List of security group names to associate with."
  type        = list(string)
  default     = null
}

variable "instancce_source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  type        = bool
  default     = true
}

variable "instancce_user_data_replace_on_change" {
  description = "When used in combination with user_data or user_data_base64 will trigger a destroy and recreate when set to true."
  type        = bool
  default     = false
}

variable "instance_volume_tags" {
  description = "Map of tags to assign, at instance-creation time, to root and EBS volumes."
  type        = map(string)
  default     = {}
}
