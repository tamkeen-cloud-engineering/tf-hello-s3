resource "local_file" "hello" {
  content  = "Hello, this is a file created with Terraform! This is awesome!"
  filename = "${path.module}/hello.txt"
}

resource "random_pet" "name" {}

resource "local_file" "pet" {
  content  = "My pet is cute! His name is ${random_pet.name.id}."
  filename = "${path.module}/pet.txt"
}
