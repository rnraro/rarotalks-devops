# Arquivo de variaveis
variable "aws" {
  description = "The values of AWS"
  type        = map(any)
  default = {
    "region"  = "us-east-1"
    "profile" = "rarolabs"
  }

}

variable "aws_az" {
  description = "Availability Zone para todos os servicos"
  default = "us-east-1a"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = "appserver"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}
