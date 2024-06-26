#impersonation provider
provider "google" {
  alias = "impersonation"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]

}


#receive short-lived access token
data "google_service_account_access_token" "default" {
  provider               = google.impersonation
  target_service_account = var.terraform_service_account
  scopes                 = ["cloud-platform", "userinfo-email"]
  lifetime               = "3600s"

}


# default provider to use the the token
provider "google" {
  project         = var.gcp_info.project
  access_token    = data.google_service_account_access_token.default.access_token
  request_timeout = "60s"
}