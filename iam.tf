# This block defines an IAM policy document for the Cluster Autoscaler policy.
data "aws_iam_policy_document" "cluster_autoscaler_policy" {

  # Define the allowed actions for this policy.
  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes"
    ]
    # Define the resources to which the actions can be applied. In this case, it's set to all resources ("*").
    resources = [
      "*",
    ]
    # Allow effect indicates that these actions are allowed for the specified resources.
    effect = "Allow"
  }
}

# This block defines an IAM policy document for assuming a role using Web Identity Federation (IRSA).
data "aws_iam_policy_document" "assume_role" {

  # Define the allowed actions for this policy.
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    # Define the principals that can assume this role. In this case, it's a federated identity provider (OIDC).
    principals {
      type        = "Federated"
      identifiers = [local.aws_iam_oidc_provider_arn]
    }

    # Define a condition under which the role can be assumed. This condition checks the subject and audience in the OIDC token.
    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.serviceaccount}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

# This block creates an IAM role for IRSA (Web Identity Federation) and specifies the role's assume role policy.
resource "aws_iam_role" "irsa" {
  name               = var.irsa_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name = "${var.irsa_role_name}"
  }
}

# This block creates a new IAM policy with the defined Cluster Autoscaler policy document.
resource "aws_iam_policy" "this" {
  name   = "eks-cluster-autoscaler-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.cluster_autoscaler_policy.json
}

# This block attaches the previously created IAM policy to the IAM role, enabling the necessary permissions for IRSA.
resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.irsa.name
}
