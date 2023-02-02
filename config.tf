terraform {
  required_providers {
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "2.9.1"
    }
  }
}

provider "pagerduty" {
  token = "u+_syrqJXqPxvBY9wvqg"
}