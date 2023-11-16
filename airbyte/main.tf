
locals {
  workspace_id = "5fb5dbed-3aec-4621-ac4c-90f48658cd97"
}


resource "airbyte_source_definition" "my_sourcedefinition" {
  source_definition = {
    docker_image_tag  = "0.1.0"
    docker_repository = "us-central1-docker.pkg.dev/gorgias-growth-production/airbyte/source-ashby"
    documentation_url = "https://immediate-tow-truck.com"
    name              = "Ashby-testbis"
  }
  workspace_id = local.workspace_id
}


resource "airbyte_source" "my_test" {
  connection_configuration = "{ \"api_key\" : \"test\" }"
  name                     = "Ashby-bis"
  source_definition_id     = airbyte_source_definition.my_sourcedefinition.source_definition_id
  workspace_id             = local.workspace_id
}


resource "airbyte_connection" "my_connection" {
  destination_id                  = "bc068a95-b1f1-43fe-ad24-ba77bdcf9b2f"
  geography                       = "auto"
  name                            = "full-tf-ashby"
  namespace_definition            = "customformat"
  namespace_format                = "airbyte_ashby"
  non_breaking_changes_preference = "ignore"
  schedule_type                   = "manual"
  source_id                       = airbyte_source.my_test.source_id
  status                          = "active"

  resource_requirements = {
    cpu_limit      = "100m"
    cpu_request    = "50m"
    memory_limit   = "1000Mi"
    memory_request = "500Mi"
  }

  sync_catalog = {
    streams = [
      {
        config = {
          selected              = true
          cursor_field          = [""]
          destination_sync_mode = "overwrite"
          sync_mode             = "full_refresh"
          primary_key = [
            [
              "id"
            ]
          ]
        }
        stream = {
          default_cursor_field  = [""]
          name                  = "applications"
          source_defined_cursor = true
          supported_sync_modes  = ["full_refresh"]
          source_defined_primary_key = [
            [
              "id"
            ]
          ],
        }
      },
    ]
  }
}
