terraform {
  source = "git@github.com:xi2481-santosh/Terraform-AWS-IAM.git"
}   


locals {
  # Automatically load input variables
  common_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}
inputs = merge(
    local.common_vars.inputs,
  {
    create_role           = true
    role_name             = "example_role"
    role_path             = "templates/ec2_assume_role_policy.json"
    additional_policy_arn = ["arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess"]

// IAM Policy

    create_policy = true
    policy_name   = "testnnk"
    policy_path   = "templates/ec2_full_access_policy.json"

// IAM OIDC Role

    create_oidc_role              = true
    oidc_role_name                = "test_oidc"
    provider_urls                 = ["oidc.eks.ap-southeast-1.amazonaws.com/id/20A96B72AD1AD56978940E78580C1B4A"]
    oidc_role_policy_arns         = ["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"]
    oidc_fully_qualified_subjects = ["system:serviceaccount:default:sa1"]
}
)
