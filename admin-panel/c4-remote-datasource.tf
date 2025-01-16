data "terraform_remote_state" "backend" {
  backend = "s3"
  config = {
    bucket = module.common_vars.backend_remote_state_bucket
    key    = module.common_vars.backend_remote_state_key
    region = var.aws_region
  }
}
