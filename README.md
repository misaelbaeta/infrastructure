# Infrastructure

  - An Infrastructure Repository (often abbreviated as "Infra Repo") is a version-controlled repository where the configuration and management of infrastructure components are defined and maintained. This approach is a key part of Infrastructure as Code (IaC) practices, allowing teams to manage their infrastructure using code, which can be versioned, reviewed, and audited like any other codebase.

## Requirements
  Terraform v1.9.3 or newer
  Kubectl
  AWS CLI



#### 1.
    
    Access folder Infra and Run:
        terraform init
        terraform apply

    to create:
     - bucket
     - tfstate


#### 2.
    Access folder Network and Run:
        terraform init
        terraform apply

    to create:
     - vpc
     - public_subnets
     - private_subnets
     - Internet Gateway
     - Nat Gateway
     - Route tables


#### 3.
    Access folder EKS and Run:  
        terraform init
        terraform apply

    to create:
    - datasource
    - eks
    - eks-sg

