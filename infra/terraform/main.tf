module "stackgen_64a68b1e-5b7d-4033-97dc-af10f3e119f0" {
  source                               = "./modules/aws_vpc"
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = false
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    Name = "my-app-vpc"
  }
}

module "stackgen_b23b0752-7f17-4a60-a950-4eb116751034" {
  source                = "./modules/aws_ec2"
  ami                   = "ami-05d2d839d4f73aafb"
  enable_public_ip      = false
  instance_type         = "t3.micro"
  key_name              = "my-finops-key"
  root_volume_encrypted = true
  root_volume_size      = 20
  root_volume_type      = "gp2"
  security_group_ids    = [module.stackgen_f71181ab-ab8f-4d7d-8fbd-f05ad68437c9.security_group_id]
  subnet_id             = module.stackgen_bdf4a6c8-d9a6-4318-8d52-da94437bd404.id
  tags = {
    Name = "myapp-ec2-stakgen"
  }
  user_data = null
}

module "stackgen_bdf4a6c8-d9a6-4318-8d52-da94437bd404" {
  source                  = "./modules/aws_subnet"
  availability_zone       = null
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "my-app-subnet"
  }
  vpc_id = module.stackgen_64a68b1e-5b7d-4033-97dc-af10f3e119f0.vpc_id
}

module "stackgen_f71181ab-ab8f-4d7d-8fbd-f05ad68437c9" {
  source      = "./modules/aws_sg"
  description = "Managed by Terraform."
  egress      = []
  ingress     = []
  name        = "my-app-sg"
  tags        = {}
  vpc_id      = module.stackgen_64a68b1e-5b7d-4033-97dc-af10f3e119f0.vpc_id
}

