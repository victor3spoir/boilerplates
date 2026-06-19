target "ansible" {
  dockerfile = "Dockerfile"
  context = "."
  tags = [ "ansible:dev" ]
}