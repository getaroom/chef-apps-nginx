name "supply_chain_utility"
description "Supply Chain Utility"

run_list(
  "role[supply_chain]",
  "role[supply_chain_utility_deployment]",
)

default_attributes({
  "scout" => {
    "gem_packages" => {
      "resque" => nil,
    },
    "key" => {
      "preprod" => "eab4ddca-cf3e-472c-b99a-83409e27adea",
      "production" => "529c722e-b833-4243-bd38-eda9d53af312",
    },
    "name" => "Utility",
  },
  "supply_chain" => {
    "resque_queues" => {
      "general" => "*,\\!content,\\!accounting",
      "purchase_card" => "cancel_purchase_card,create_purchase_card,update_purchase_card",
      "content" => "content",
      "accounting" => "accounting",
    },
    "resque_queue_memory_limits" => Hash.new("400 MB").merge(
      "accounting" => "1000 MB"
    ),
  },
})
