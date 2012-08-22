describe_recipe "apps-nginx::site" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "the www application" do
    describe "nginx site file" do
      let(:site) { file "/etc/nginx/sites-available/www.conf" }
      let(:stat) { File.stat site.path }

      it "exists" do
        site.must_exist
      end

      it "is owned by root" do
        assert_equal 0, stat.uid
        assert_equal 0, stat.gid
      end

      it "only allows the owner to write but everyone to read" do
        assert_equal "644".oct, (stat.mode & 007777)
      end

      it "defaults to using the www.conf.erb template in the www cookbook" do
        site.must_include "# www/www.conf.erb"
      end

      it "has access to the application data bag" do
        site.must_include "server_name www;"
      end
    end

    describe "enabled nginx site symlink" do
      let(:site) { link "/etc/nginx/sites-enabled/www.conf" }

      it "exists" do
        site.must_exist
      end

      it "is symbolic" do
        site.must_have :link_type, :symbolic
      end

      it "links to the available site file" do
        site.must_have :to, "/etc/nginx/sites-available/www.conf"
      end
    end
  end

  describe "a customized application" do
    describe "nginx site file" do
      let(:site) { file "/etc/nginx/sites-available/luigi.conf" }
      let(:stat) { File.stat site.path }

      it "exists" do
        site.must_exist
      end

      it "is owned by root" do
        assert_equal 0, stat.uid
        assert_equal 0, stat.gid
      end

      it "only allows the owner to write but everyone to read" do
        assert_equal "644".oct, (stat.mode & 007777)
      end

      it "uses a custom template from a custom cookbook" do
        site.must_include "# custom_cookbook/custom_template.conf.erb"
      end
    end

    describe "enabled nginx site symlink" do
      let(:site) { link "/etc/nginx/sites-enabled/luigi.conf" }

      it "exists" do
        site.must_exist
      end

      it "is symbolic" do
        site.must_have :link_type, :symbolic
      end

      it "links to the available site file" do
        site.must_have :to, "/etc/nginx/sites-available/luigi.conf"
      end
    end
  end

  describe "an application not hosted on this server" do
    it "does not create an nginx site file" do
      file("/etc/nginx/sites-available/princess.conf").wont_exist
    end

    it "does not create an enabled nginx site symlink" do
      link("/etc/nginx/sites-enabled/princess.conf").wont_exist
    end
  end

  describe "an application hosted on this server but not using nginx" do
    it "does not create an nginx site file" do
      file("/etc/nginx/sites-available/toad.conf").wont_exist
    end

    it "does not create an enabled nginx site symlink" do
      link("/etc/nginx/sites-enabled/toad.conf").wont_exist
    end
  end
end
