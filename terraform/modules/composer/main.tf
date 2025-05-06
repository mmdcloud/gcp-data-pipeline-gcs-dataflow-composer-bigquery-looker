resource "google_composer_environment" "composer" {
  name   = var.name
  region = var.location
  config {
    software_config {
      image_version = var.image_version
    }
  }
}