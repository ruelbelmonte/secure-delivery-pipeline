variable "github_repository" {
  description = "owner/repo, exactly as shown on GitHub. The OIDC sub claim match is case-sensitive."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9-]+/[A-Za-z0-9._-]+$", var.github_repository))
    error_message = "Must be in owner/repo form."
  }
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "create_oidc_provider" {
  description = "Set false if the account already has the token.actions.githubusercontent.com provider (one per account)."
  type        = bool
  default     = true
}
