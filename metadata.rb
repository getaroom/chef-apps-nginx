name             "apps-nginx"
maintainer       "getaroom"
maintainer_email "devteam@roomvaluesteam.com"
license          "MIT"
description      "Configures nginx for Apps"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

depends "apps"
depends "nginx"

supports "debian"
supports "ubuntu"

recipe "apps-nginx", "Configures nginx for apps."
recipe "apps-nginx::site", "Generates an nginx site."
