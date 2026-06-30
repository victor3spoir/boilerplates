variable "IMAGE" {
  default = "appname"
}

variable "TAG" {
  default = "dev"
}

group "default" {
  targets = [ 
  "frontend", 
  "backend" 
  ]
}

target "frontend" {
  context = "./frontend"
  dockerfile = "Dockerfile"  
  tags = [ "${IMAGE}/frontend:${TAG}" ]
  
  secret = [
    {type="env", id="ENV_ID"},
   ]
}

target "backend" {
  context = "./backend"
  dockerfile = "Dockerfile"
  tags = [ "${IMAGE}/backend:${TAG}" ]
}