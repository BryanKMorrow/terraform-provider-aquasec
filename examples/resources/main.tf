terraform {
  required_providers {
    aquasec = {
      version = "1.0"
      source  = "github.com/aquasec/aquasec"
    }
  }
}

provider "aquasec" {
  username = "admin"
  aqua_url = "https://aquaurl.com"
  password = "@password"
}


resource "aquasec_user" "name" {
  user_id  = "terraform-user"
  password = "password"
  name     = "Terraform User"
  email    = "terraform@test.com"
  roles = [
    "Scanner",
    "Administrator"
  ]
}

resource "aquasec_integration_registry" "demoregistry" {
  name = "terraform-ecr"
  url = "us-east-1"
  type = "AWS"
  username = "APIKEY"
  password = "SECRETKEY"
  prefixes = [
    "111111111111.dkr.ecr.us-east-1.amazonaws.com"
  ]
  auto_pull = true
}
resource "aquasec_firewall_policy" "test-policy" {
  name = "test-firewall-policy"
  description = "this is a test firewall policy"

  block_icmp_ping = true
  block_metadata_service = false

  inbound_networks {
    allow = true
    port_range = "8080-9999"
    resource_type = "anywhere"
  }

  outbound_networks {
    allow = false
    port_range = "6060-7070"
    resource_type = "anywhere"
  }
}