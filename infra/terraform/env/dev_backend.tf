terraform {
  backend "s3" {
    bucket = "srinivas-terraform-state"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
