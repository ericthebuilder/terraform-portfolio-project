terraform {
    backend "s3"{
        bucket = "ea-my-terraform-state"
        key = "global/s3/terraform.tfstate"
        region = "us-west-2"
    dynamodb_table = "terraform-locks"
    }

    }