output "irsa_iam_role_arn" {
  description = "IRSA Demo IAM Role ARN"
  value       = aws_iam_role.irsa.arn
}

