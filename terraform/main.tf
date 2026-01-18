terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  
  name = var.cluster_name
  cidr = "10.0.0.0/16"
}

module "eks" {
  source = "./modules/eks"
  
  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  instance_types  = ["t3.medium"]
}
