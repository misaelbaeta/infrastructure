variable "AWS_REGION" {
  default     = "us-east-1"
  description = "aws region"
}

variable "cluster_name" {
  default = "sre"
}
variable "kubernetes_version" {
  default     = "1.30"
  description = "kubernetes version"
}

variable "iam_access_entries" {
  type = list(object({
    policy_arn    = string
    principal_arn = string
  }))

  default = [
    {
      policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      principal_arn = "arn:aws:iam::008025567304:user/hamelek"
    },
    {
      policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      principal_arn = "arn:aws:iam::008025567304:role/eks-cluster-sre"
    },

  ]
}
