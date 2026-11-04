mock "tfplan/v2" {
  module {
    source = "../../../tests/sovereignty/mock-tfplan-pass-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
