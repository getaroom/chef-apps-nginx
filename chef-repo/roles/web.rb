name "web"
description "Tests for nginx"

run_list(
  "recipe[users::sysadmins]",
  "recipe[apps]",
  "recipe[nginx]",
  "recipe[custom_cookbook]",
  "recipe[www]",
  "recipe[apps-nginx]",
)

default_attributes({
  "minitest" => {
    "tests" => "apps-nginx/*_test.rb",
  },
})
