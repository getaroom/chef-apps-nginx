describe ('/etc/nginx/sites-available/www.conf') do
    it { should be_file }
    it { should_not be_directory }
    it { should be_owned_by 'root' }
end

describe ('/etc/nginx/sites-available/luigi.conf') do
    it { should be_file }
    it { should_not be_directory }
    it { should be_owned_by 'root' }
end
