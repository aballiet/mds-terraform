terraform {
  required_providers {
    airbyte = {
      source = "aballiet/airbyte"
    }
  }
}

provider "airbyte" {
  # Configuration options
  username   = ""
  password   = ""
  server_url = "http://localhost:8001/api"
}
