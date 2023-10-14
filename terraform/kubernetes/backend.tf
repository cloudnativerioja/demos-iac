terraform {
  backend "s3" {
    bucket = "terraform-states"
    key    = "terraform.tfstate"

    region                      = "main"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style            = true
  }
}