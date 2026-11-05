module "tfconfig-functions" {
  source = "../../common-functions/tfconfig-functions.sentinel"
}

mock "tfconfig/v2" {
  module {
    source = "../../../tests/allowed_providers/mock-tfconfig-fail-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
