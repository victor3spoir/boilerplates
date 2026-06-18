target "frappe" {
  context = "."
  dockerfile = "Dockerfile"
  tags = [ "frappecms:dev" ]
}
