/*
resource "azuread_application" "CyberArkOIDC" {
  display_name     = "CyberArk OIDC"
  owners           = ["c1862467-a2c7-479b-a59d-6f0aa0521809"]
  sign_in_audience = "AzureADMyOrg"

  api {
    mapped_claims_enabled          = false
    requested_access_token_version = 1

  }

  fallback_public_client_enabled = true

  group_membership_claims = [
    "None"
  ]

  optional_claims {
    access_token {
      name = "upn"
    }

    id_token {
      name      = "upn"
      essential = false
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "14dad69e-099b-42c9-810b-d002981feec1"
      type = "Scope"
    }
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }

  web {
    logout_url    = "https://login.microsoftonline.com/f995c4e8-3b73-4ede-9146-2234a3c136d7/oauth2/v2.0/logout"
    redirect_uris = ["https://labpvwa01.bqscust.banqsoft.net/PasswordVault/api/Auth/OIDC/Azure/Token"]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

}
*/