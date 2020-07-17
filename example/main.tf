
provider "aws" {
  region  = "eu-west-1"
  version = ">= 2.38.0"
}

module "vpc" {
  source  = "mehdi-wsc/vpc-wsc/aws"
  version = "0.0.3"

  group                = "group"
  env                  = "test"
  owner                = "github"
  firstname            = "antonio"
  lastname             = "josef"
  region               = "eu-west-1"
  vpc_cidr             = "20.0.0.0/22"
  public_subnet_count  = "2"
  private_subnet_count = "1"
  cidr_block_private   = ["20.0.0.64/28"]
  cidr_block_public    = ["20.0.0.0/28", "20.0.1.16/28"]

}
module "eks-wescale" {
  source  = "mehdi-wsc/iam-wsc/aws"
  version = "0.0.1"
  principals = {
    Service = "eks.amazonaws.com"
  }

  name_iam_role = "wescale-eks"

  defined_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  ]

}

module "sg-eks-wescale" {
  source  = "mehdi-wsc/sg-wsc/aws"
  version = "0.0.1"

  name           = "eks-wescale"
  sg_description = "Cluster communication with worker nodes"
  vpc_id         = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Allow workstation to communicate with the cluster API Server"
      cidr_blocks = local.workstation-external-cidr
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"

    }
  ]
  tags = {
    Name = "terraform-eks-wespeakcloud"
  }

}

module "integ_node_group_role" {
  source  = "mehdi-wsc/iam-wsc/aws"
  version = "0.0.1"
  principals = {
    Service = "ec2.amazonaws.com"
  }

  name_iam_role = "eks-node-group"

  defined_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

}


module "kube_cluster" {
  source             = "mehdi-wsc/eks/aws"
  version            = "0.0.1"
  name               = "kube"
  role               = module.eks-wescale.iam_arn
  security_group_ids = [module.sg-eks-wescale.sg_id]
  subnet_ids         = module.vpc.public_subnet_ids
  depends            = module.eks-wescale.iam_defined_attachements
}

output "endpoint" {
  value = module.kube_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = module.kube_cluster.kubeconfig-certificate-authority-data
}

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}
locals {
  workstation-external-cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
}
