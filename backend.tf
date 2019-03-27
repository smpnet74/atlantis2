# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "atlantis2"

    workspaces {
      name = "test-app-dev"
    }
  }
}
