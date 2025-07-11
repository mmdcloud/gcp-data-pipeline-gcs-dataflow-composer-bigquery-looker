resource "google_looker_instance" "looker-instance" {
  name              = var.name
  platform_edition  = var.platform_edition
  region            = var.location
  public_ip_enabled = var.public_ip_enabled
  deletion_policy   = var.deletion_policy
  oauth_config {
    client_id     = var.oauth_client_id
    client_secret = var.oauth_client_secret
  }
}
