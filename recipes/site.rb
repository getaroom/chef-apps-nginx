#
# Cookbook Name:: apps-nginx
# Recipe:: site
#
# Copyright 2012, getaroom
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

search :apps do |app|
  if (app.fetch("nginx_roles", []) & node.run_list.roles).any?
    if app.fetch("ingredients", {}).any? { |role, ingredients| node.run_list.roles.include?(role) && ingredients.include?("nginx_site") }
      template "#{node['nginx']['dir']}/sites-available/#{app['id']}.conf" do
        source app['nginx_site_template'] || "#{app['id']}.conf.erb"
        cookbook app['nginx_site_cookbook'] || app['id']
        owner "root"
        group "root"
        mode "644"
        variables :app => app
        notifies :reload, "service[nginx]"
      end

      nginx_site "#{app['id']}.conf"
    end
  end
end
