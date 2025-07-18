resource "aws_secretsmanager_secret" "secret" {
  description = "Administrator password for instance ${var.instanceid}"
  kms_key_id  = data.aws_kms_key.ssm.id
  name        = "${var.secret_name_prefix}${var.instanceid}"
  tags = {
    hostname = var.hostname
    CreatedBy       = var.created_by
    InstanceID      = var.instance_id
    Env             = var.env
    instanceid      = var.instanceid
  }
  #policy =
}

data "aws_kms_key" "ssm" {
  key_id = "alias/aws/secretsmanager"
}


resource "aws_secretsmanager_secret_rotation" "secret_rotation" {
  rotation_lambda_arn = var.rotation_lambda_arn
  rotation_rules {
    automatically_after_days = var.rotation_days
  }
  secret_id = aws_secretsmanager_secret.secret.id
}

resource "aws_secretsmanager_secret_version" "secret" {
  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = <<EOF
{
  "Administrator": "fake password will the added at the first rotation",
}
EOF
}
