locals {
  config_yaml = yamldecode(file("./configuration.yaml"))
  vars        = local.config_yaml
}