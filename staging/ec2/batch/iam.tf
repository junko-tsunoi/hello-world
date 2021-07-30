module "iam_role" {
  source = "../../../module/iam/role"

  principal_service = ["ec2.amazonaws.com"]
  role_name         = "${local.Project}${local.Env}${local.Use}EC2Role"
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy",
    "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy",
    aws_iam_policy.associate_address.arn
  ]
  create_instance_profile = true

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}

data "template_file" "associate_address" {
  template = file("./templates/associate_address.json")
  vars = {
    ec2_resourcetag_name = "${local.project}-${local.env}-${local.use}"
  }
}

resource "aws_iam_policy" "associate_address" {
  name   = "${local.Project}${local.Env}${local.Use}AssociateAddress"
  path   = "/"
  policy = data.template_file.associate_address.rendered
}

