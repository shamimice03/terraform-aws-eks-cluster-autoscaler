## EKS Cluster Autoscaler
### Usage:

```hcl
module "cluster_autoscaler" {
  
  source = "shamimice03/eks-cluster-autoscaler/aws"
  
  cluster_name      = "eks-cluster"
  oidc_provider_arn = "arn:aws:iam::3213213213214:oidc-provider/oidc.eks.ap-northeast-1.amazonaws.com/id/DF928045AFF0184B16D3EE5AC4E52B32"
  irsa_role_name    = "ClusterAutoscalerIRSA"
  namespace         = "kube-system"
  create_namespace  = false
  serviceaccount    = "cluster-autoscaler-sa"
  chart_repo        = "https://kubernetes.github.io/autoscaler"
  chart_name        = "cluster-autoscaler"
  release_name      = "cluster-autoscaler"
  chart_version     = "9.29.1"
  
  set = [
    {
      name  = "autoDiscovery.clusterName"
      value = "eks-cluster"
    },
    {
      name  = "awsRegion"
      value = "ap-northeast-1"
    },
    {
      name  = "rbac.serviceAccount.name"
      value = "cluster-autoscaler-sa"
    }
  ]
  
  set_annotations = ["rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"]

}

```

### How `set_annotations` works:

```hcl
# For adding annotations in the service-account ( set_annotations = ["rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"] )

# Internally used in following way:
 set = [
  {
   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
   value = <-IRSA-ARN->  
   }
  ]

```

<!--### VPC Outputs-->

<!--```-->
<!--db_subnet_id = []-->
<!--igw_id = "igw-0f869b45784c526e0"-->
<!--intra_subnet_id = [-->
<!--  "subnet-06e919d48f43eba1b",-->
<!--  "subnet-0820c186039b2d4ac",-->
<!--]-->
<!--private_subnet_id = [-->
<!--  "subnet-057c23897b5ea074f",-->
<!--  "subnet-014e8b35dc15e7f29",-->
<!--]-->
<!--public_subnet_id = [-->
<!--  "subnet-021604cca828cfb0d",-->
<!--  "subnet-06c70c11d9fbd5fd5",-->
<!--]-->
<!--vpc_cidr_block = "10.0.0.0/16"-->
<!--vpc_id = "vpc-0925410d256a3ab11"-->

<!--```-->
