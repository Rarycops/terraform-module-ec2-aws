module "EC2" {
  source = "../../"

  instance_type = "t4g.nano"
  instance_ami  = "test"
  # instance_ephemeral_map = {
  #   "name" = {
  #     device_name  = "value"
  #     no_device    = false
  #     virtual_name = "value"
  #   }
  # }
  # instance_ebs_block_device_map = {
  #   "name" = {
  #     delete_on_termination = false
  #     device_name           = "test"
  #     encrypted             = false
  #     iops                  = 0
  #     kms_key_id            = "value"
  #     snapshot_id           = "value"
  #     tags = {
  #       "name" = "value"
  #     }
  #     throughput  = 0
  #     volume_size = 0
  #     volume_type = "value"
  #   }
  # }
  instance_root_block_device_map = {
    "name" = {
      delete_on_termination = false
      encrypted             = false
      iops                  = 0
      kms_key_id            = "value"
      tags = {
        "name" = "value"
      }
      throughput  = 0
      volume_size = 0
      volume_type = "value"
    }
  }
}
