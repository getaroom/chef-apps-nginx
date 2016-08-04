name "supply_chain_deployment"
description "Supply Chain Deployment"

run_list(
  "recipe[supply_chain::app_yml]",
  "recipe[supply_chain::mongoid_yml]",
)

default_attributes({
  "authorization" => {
    "sudo" => {
      "groups" => ["supply_chain"],
    },
  },
})
