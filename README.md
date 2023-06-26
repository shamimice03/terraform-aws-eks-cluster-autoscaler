```
cluster_name      = "eks-cluster"
oidc_provider_arn = "arn:aws:iam::391178969547:oidc-provider/oidc.eks.ap-northeast-1.amazonaws.com/id/271D381BE8F9E7A4254F0DC708CC6015"
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
    value = "eks-cluster_name"
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

# # Equivalent to the following but the ARN is only known internally to the module
# set = [{
#   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#   value = iam_role_arn.this[0].arn
# }]
```

- https://letsmake.cloud/eks-cluster-autoscaler
- https://github.com/DNXLabs/terraform-aws-eks-cluster-autoscaler/blob/master/helm.tf
- https://github.com/kubernetes/autoscaler/blob/master/charts/cluster-autoscaler/values.yaml
- https://github.com/aws-ia/terraform-aws-eks-blueprints-addon/blob/main/main.tf
- 