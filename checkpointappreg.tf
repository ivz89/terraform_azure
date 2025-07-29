/*
resource "azuread_application" "CheckpointTest" {
  display_name     = "Checkpoint-Test"
  owners           = ["c1862467-a2c7-479b-a59d-6f0aa0521809"] # Endre denne til object ID til din bruker
  sign_in_audience = "AzureADMyOrg"

  api {
    mapped_claims_enabled          = false
    requested_access_token_version = 1

  }

  fallback_public_client_enabled = false

  # Claims og ID tokens kan sløyfes om du logger på med secret
  /*optional_claims {
    access_token {
      name = "upn"
    }

    id_token {
      name                  = "upn"
      essential             = false
    }
  }
  

    required_resource_access {
        resource_app_id = "00000003-0000-0000-c000-000000000000" # MS Graph

        resource_access {
            id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.read
            type = "Scope"
        }

        /*resource_access {
            name = "Network Contributor"
            id   = "4d97b98b-1d4f-4787-a291-c67834d212e7" # Network Contributor
            type = "Scope"
        }*/
/*    }

    app_role {
        allowed_member_types = [
            "Application",
            ]
        description          = "Network Contributor role"
        display_name         = "Network Contributor role"
        enabled              = true
        id                   = "e8927387-2acf-4813-b185-3478d8361470"
        value                = "Microsoft.Network/*"
        }

    web {
        logout_url    = "https://meaningful-logout-URL-here" # Bytt denne til passende logout URL
        redirect_uris = ["https://localhost/vmss-name"] # Bytt denne til passende redirect URL

        implicit_grant {
            access_token_issuance_enabled = false
            id_token_issuance_enabled     = false
    }
  }

  tags = []
}

resource "time_rotating" "CheckpointRotate" {
  rotation_days = 180
}

resource "azuread_application_password" "CheckpointSecret" {
  application_object_id = azuread_application.CheckpointTest.object_id
  rotate_when_changed = {
    rotation = time_rotating.CheckpointRotate.id
  }
  display_name = "Checkpoint Secret"
}

output "key2" {

  value = azuread_application_password.CheckpointSecret.value

  sensitive = true

}*/