variable "secret_name_prefix" {
  description = "should be something like vault_instanceid, cannot be duplicates name in the secrets and when you delete the name is retained at least for 7 days"
}

variable "instanceid" {
  description = "the instance id like i-00112233445566"
}

variable "rotation_days" {
  default     = 30
  description = "how often the password needs to be rotated"
}

variable "rotation_lambda_arn" {
  description = "the arn of the lambda that perform the rotation, is created with the other module"
}

variable "aws_region" {
  description = "Region to run as"
}

variable "env" {
  description = "Env to execute TF in"
}

variable "hostname" {
  description = "Tag host name"
}

variable "created_by" {
  description = "List of tags should be associated on all ressoruces -- Created By"
}

variable "instance_id" {
  description = "List of tags should be associated on all ressoruces -- Instance Id"
}

