output "AWS_PLAN_ROLE_ARN" {
  value = aws_iam_role.plan.arn
}

output "AWS_ROLE_ARN" {
  value = aws_iam_role.apply.arn
}

output "TF_STATE_BUCKET" {
  value = aws_s3_bucket.state.id
}

output "AWS_REGION" {
  value = var.aws_region
}
