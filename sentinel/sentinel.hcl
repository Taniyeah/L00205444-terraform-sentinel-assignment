policy "sovereignty" {
  source            = "./sovereignty.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "instance_type" {
  source            = "./instance_type.sentinel"
  enforcement_level = "advisory"
}

module "tfconfig-functions" {
  source = "./common-functions/tfconfig-functions.sentinel"
}

policy "allowed_providers" {
  source            = "./allowed_providers.sentinel"
  enforcement_level = "advisory"
}
