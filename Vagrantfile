home = ENV['HOME']
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "otus-linux-pro-vm2"
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    v.check_guest_additions = false
    v.name = "vm2"
    if !File.exist?(home + "/disk0.vdi")
      v.customize ["createhd",  "--filename", home + "/disk0.vdi", "--size", 512]
    end
    if !File.exist?(home + "/disk1.vdi")
      v.customize ["createhd",  "--filename", home + "/disk1.vdi", "--size", 512]
    end
    if !File.exist?(home + "/disk2.vdi")
      v.customize ["createhd",  "--filename", home + "/disk2.vdi", "--size", 512]
    end
    if !File.exist?(home + "/disk3.vdi")
      v.customize ["createhd",  "--filename", home + "/disk3.vdi", "--size", 512]
    end
    v.customize ["storagectl", :id, "--name", "SATA Controller", "--add", "sata"]
    v.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "1", "--type", "hdd", "--medium", home + "/disk0.vdi"]
    v.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "2", "--type", "hdd", "--medium", home + "/disk1.vdi"]
    v.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "3", "--type", "hdd", "--medium", home + "/disk2.vdi"]
    v.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "4", "--type", "hdd", "--medium", home + "/disk3.vdi"]
  end
  config.vm.provision "shell", path: "script.sh"
end
