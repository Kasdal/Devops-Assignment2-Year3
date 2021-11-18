# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  name                   = "${var.environment}-BastionHost"
  #instance_count         = 1
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  user_data = file("${path.module}/monitor.sh")
  tags = local.common_tags
}



module "ec2_private_DB" {
  depends_on = [ module.vpc ] 
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  # insert the 10 required variables here
  name                   = "${var.environment}-db"
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  #monitoring             = true
  vpc_security_group_ids = [module.mongo_sg.security_group_id]
  subnet_id              = module.vpc.database_subnets[0]   
  instance_count         = var.private_instance_count
  user_data = file("${path.module}/docker.sh")
  tags = local.common_tags
}




# EC2 Instance Variables

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.nano"  
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "Key pair that need to be associated with EC2 Instance"
  type = string
  default = "web13"
}

# AWS EC2 Private Instance Count
variable "private_instance_count" {
  description = "AWS EC2 Private Instances Count"
  type = number
  default = 1  
}








# AWS EC2 Instances Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public.public_ip 
}