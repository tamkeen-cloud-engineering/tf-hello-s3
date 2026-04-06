resource "local_file" "hello" {
  content  = "Hello, this is a file created with Terraform! This is awesome!"
  filename = "${path.module}/hello.txt"
}
