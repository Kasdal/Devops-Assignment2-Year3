# Define Local Values in Terraform
locals {
  owners = var.group
  environment = var.environment
  name = "${var.group}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }

  asg_tags = [
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "foo"
      value               = ""
      propagate_at_launch = true
    },
  ]

} 