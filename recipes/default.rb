#
# Cookbook Name:: learn_chef_iis
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
powershell_script 'Install IIS' do
  code 'Add-WindowsFeature Web-Server'
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-Server).Installed"
end

service 'w3svc' do
  action [:enable, :start]
end

template 'c:\inetpub\wwwroot\Default.htm' do
  source 'Default.htm.erb'
end

powershell_script "Firewall_Rules" do
	code <<-EOH
		netsh advfirewall firewall add rule dir=IN action=ALLOW name="Firewall_Rule" protocol=TCP localport=80 Remoteip=any profile=any
	EOH
end