# Create DNS zone

resource "technitium_zone" "home" {
  name = "home.arpa"

  type = "Primary"
}



resource "technitium_record" "app1" {
  domain = "home.arpa"

  type = "A"
  ttl  = 300

  aname = "app1"
  value = "10.96.7.138"
}

resource "technitium_record" "app2" {
  domain = "home.arpa"

  type = "A"
  ttl  = 300

  aname = "app2"
  value = "10.96.7.138"
}