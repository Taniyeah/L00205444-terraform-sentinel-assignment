module "tfconfig-functions" {
  source = "../../common-functions/tfconfig-functions.sentinel"
}

mock "tfconfig/v2" {
  module {
    source = "../../../tests/allowed_providers/mock-tfconfig-pass-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
