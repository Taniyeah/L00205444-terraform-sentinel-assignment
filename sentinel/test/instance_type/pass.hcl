mock "tfplan/v2" {
  module {
    source = "../../../tests/instance_type/mock-tfplan-pass-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
