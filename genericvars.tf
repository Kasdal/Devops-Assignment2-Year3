# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-west-1"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "assignemnt2-demo"
}
# Gruop Name
variable "group" {
  description = "Project group designation"
  type = string
  default = "demo"
}
