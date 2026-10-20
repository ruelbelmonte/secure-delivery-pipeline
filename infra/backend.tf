# bucket and region are passed with -backend-config so forks need no edits.
terraform {
  backend "s3" {
    key          = "secure-delivery-pipeline/infra.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
