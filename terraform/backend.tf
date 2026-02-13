terraform {
  backend "s3" {
    bucket         = "bedrock-terraform-state-owolabi"
    key            = "project-bedrock/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}


 