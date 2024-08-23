resource "null_resource" "pre_eks_dependencies" {
  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
    module.eks
  ]
}


module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "20.20.0"
  cluster_name                   = var.cluster_name
  cluster_version                = var.kubernetes_version
  cluster_endpoint_public_access = true
  #vpc_id          = data.aws_vpc.sre_vpc.id   
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  #subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids # ou public_subnet_ids se necessário
  subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  enable_irsa = true
  #enabled_cluster_log_types = ["controllerManager", "scheduler"]
  tags = {
    cluster = var.cluster_name
  }

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.node_group.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = 1
      max_size     = 4
      desired_size = 2
    }
  }
}

resource "aws_eks_access_entry" "eks_access_entry" {
  depends_on = [module.eks]
  for_each   = { for entry in var.iam_access_entries : entry.principal_arn => entry }
  #cluster_name  = aws_eks_cluster.eks.name # ensure that eks cluster is created with name eks
  cluster_name  = var.cluster_name
  principal_arn = each.value.principal_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_policy_association" {
  depends_on = [module.eks]
  for_each   = { for entry in var.iam_access_entries : entry.principal_arn => entry }
  #cluster_name  = aws_eks_cluster.eks.name # ensure that eks cluster is created with name eks
  cluster_name  = var.cluster_name
  policy_arn    = each.value.policy_arn
  principal_arn = each.value.principal_arn

  access_scope {
    type = "cluster"
  }
}