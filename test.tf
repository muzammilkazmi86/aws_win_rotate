module "windows-password-lambda-rotation" {
  source  = "./lambda/"
  prefix  = "win_vault"
  instance_id   = "i-0aee831e0b76d7854"
  aws_region       = "us-east-1"
  hostname         = "test-2025"
  created_by       = "syed"
  env              = "test"
}


module "windows-password-rotation-secret-manager" {
  source  = "./Secret/"
  secret_name_prefix = "vault_"
  instanceid = "i-0aee831e0b76d7854"
  rotation_lambda_arn = "${module.windows-password-lambda-rotation.lambda_arn}"
  instance_id   = "i-07172883b37fb80e8"
  hostname = "test-2025"
  aws_region       = "us-east-1"
  created_by       = "syed"
  env              = "test"
}