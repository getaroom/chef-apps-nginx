name "supply_chain_utility_deployment"
description "Supply Chain Utility Deployment"

run_list(
  "role[supply_chain_deployment]",
  "recipe[supply_chain::resque]",
  "recipe[supply_chain::resque_scheduler]",
)
