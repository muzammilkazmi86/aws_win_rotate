# Supported component
    1. Pythont 3.13
    2. terraform version v0.15.3

# Instructions 

## STEP 1
Run the code below.
```bash
module "windows-password-lambda-rotation" {
  source  = "./windows-password-lambda-rotation/"
  prefix  = "Win-vault-test"
  instance_id   = "i-0aee831e0b76d7854"
  aws_region       = "us-east-1"
  created_by       = "syed"
}
```

## STEP 2
Ensure the following policies are added:
```bash
EC2Rescue Task Policy:
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "kms:Decrypt",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ssm:PutParameter",
            "Resource": "arn:aws:ssm:us-east-1:*:parameter/EC2Rescue/Passwords/i-*"
        }
    ]
}
```
## STEP 3
### Policies Needed:

####KMS Decrypt Policy:
```bash
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "kms:Decrypt",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ssm:PutParameter",
            "Resource": "arn:aws:ssm:us-east-1:*:parameter/EC2Rescue/Passwords/i-*"
        }
    ]
}
```
####AmazonEC2RoleforSSM

## STEP 4

Ensure SSM Can communicate to server: Example command: 
```python
aws ssm send-command --instance-ids i-07172883b37fb80e8 --document-name AWS-RunPowerShellScript --parameters commands="dir c:"
```

### STEP 5
1. Ensure the following agent is running:
        > SSM Should be synced.
        > AWS Powershell tools should be installed on the EC2 instance.

### STEP 6
1. After all the above is setup, follow the command below:
```bash
module "windows-password-rotation-secret-manager" {
  source  = "./windows-password-rotation-secret-manager"
  secret_name_prefix = "vault_"
  instance_id = "i-0aee831e0b76d7854"
  instanceid = "i-0aee831e0b76d7854"
  rotation_lambda_arn = "${module.windows-password-lambda-rotation.lambda_arn}"
  aws_region       = "us-east-1"
  created_by       = "created_by"
}
```

## TROUBLESHOOTING COMMANDS

1. Here are some helpful commands for troubleshooting secrets, pending AWS jobs can be moved by using the following (Sample example, do not copy paste)
```python
aws secretsmanager list-secrets
```

```python
aws secretsmanager update-secret-version-stage --version-stage AWSPENDING --remove-from-version-id terraform-20250718132628637600000003 --secret-id vault_i-0aee831e0b76d7854
```

```python
aws secretsmanager delete-secret --secret-id vault_i-0aee831e0b76d7854 --force-delete-without-recovery
```

