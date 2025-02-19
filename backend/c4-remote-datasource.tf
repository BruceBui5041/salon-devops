data "terraform_remote_state" "database" {
  backend = "s3"
  config = {
    bucket = module.common_vars.remote_state_bucket
    key    = module.common_vars.backend_remote_state_key
    region = var.aws_region
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = module.common_vars.remote_state_bucket
    key    = module.common_vars.network_remote_state_key
    region = var.aws_region
  }
}

data "terraform_remote_state" "proxy" {
  backend = "s3"
  config = {
    bucket = module.common_vars.remote_state_bucket
    key    = module.common_vars.proxy_remote_state_key
    region = var.aws_region
  }
}

data "terraform_remote_state" "proxy_eip" {
  backend = "s3"
  config = {
    bucket = module.common_vars.remote_state_bucket
    key    = module.common_vars.proxy_eip_remote_state_key
    region = var.aws_region
  }
}
