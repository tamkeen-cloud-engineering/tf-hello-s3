variable "region" {
  default = "us-east-1"
  type = string
  description = "The region to deploy your resources."
}

variable "profile" {
  default = "sandbox"
  type = string
  description = "The AWS CLI profile to use for authentication."
}

variable "name_prefix" {
  default = "your-name"
  type = string
  description = "The bucket prefix name."
}

locals {
  first_bucket_prefix = "${var.name_prefix}-${var.region}-${var.profile}"
  second_bucket_prefix = "${random_pet.bucket.id}-"
}

resource "random_pet" "bucket" {
  length = 4
}

provider "aws" {
  region = var.region
  profile = var.profile
}

resource "aws_s3_bucket" "my_first_bucket" {
  bucket_prefix = local.first_bucket_prefix
  force_destroy = true
}

resource "aws_s3_bucket" "my_second_bucket" {
  bucket_prefix = local.second_bucket_prefix
  force_destroy = true
}

resource "aws_s3_object" "upload_file_to_first_bucket" {
  bucket = aws_s3_bucket.my_first_bucket.id
  key = "hello.txt"
  source = "${path.module}/hello.txt"
}

resource "aws_s3_object" "upload_file_to_second_bucket" {
  bucket = aws_s3_bucket.my_second_bucket.id
  key = "hello.txt"
  source = "${path.module}/hello.txt"
}
