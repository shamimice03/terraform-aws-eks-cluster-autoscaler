locals {
  aws_iam_oidc_provider_arn = var.oidc_provider_arn
  oidc_provider             = element(split("oidc-provider/", "${var.oidc_provider_arn}"), 1)
}


#######################################################################
#                     Cluster Autoscaler
#######################################################################

resource "helm_release" "example" {
  name             = coalesce(var.release_name, var.chart_name)
  repository       = var.chart_repo
  chart            = var.chart_name
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = var.create_namespace

  dynamic "set" {

    for_each = var.set

    content {
      name  = set.value.name
      value = set.value.value
    }

  }

  dynamic "set" {

    for_each = { for k, v in toset(var.set_annotations) : k => v }
    iterator = each
    content {
      name  = each.value
      value = aws_iam_role.irsa.arn
    }
  }

  #   dynamic "set" {
  #   for_each = { for k, v in toset(var.set_irsa_names) : k => v if var.create && var.create_role }
  #   iterator = each
  #   content {
  #     name  = each.value
  #     value = aws_iam_role.this[0].arn
  #   }
  # }
}