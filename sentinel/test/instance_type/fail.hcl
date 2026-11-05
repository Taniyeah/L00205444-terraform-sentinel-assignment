mock "tfplan/v2" {
  module {
    source = "../../../tests/instance_type/mock-tfplan-fail-v2.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
