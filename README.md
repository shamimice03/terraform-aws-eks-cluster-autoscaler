```
cluster_name      = "eks-cluster"
oidc_provider_arn = "arn:aws:iam::391178969547:oidc-provider/oidc.eks.ap-northeast-1.amazonaws.com/id/DF928045AFF0184B16D3EE5AC4E52B32"
irsa_role_name    = "ClusterAutoscalerIRSA"
namespace         = "cluster-autoscaler"
create_namespace  = true
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


# For adding annotations in the service-account 
set_annotations = ["rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"]

# # Internally used in following way:
# set = [
#  {
#   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#   value = <-IRSA-ARN->  
#   }
#  ]

```

- https://letsmake.cloud/eks-cluster-autoscaler
- https://github.com/DNXLabs/terraform-aws-eks-cluster-autoscaler/blob/master/helm.tf
- https://github.com/kubernetes/autoscaler/blob/master/charts/cluster-autoscaler/values.yaml
- https://github.com/aws-ia/terraform-aws-eks-blueprints-addon/blob/main/main.tf
- 