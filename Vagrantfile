# -*- mode: ruby -*-
# vi: set ft=ruby :

module Platforms
  class Config
    include Singleton
    attr_reader :path

    def initialize
      @path = File.join(File.expand_path(File.dirname(__FILE__)), 'virtualbox-settings')
      @data = load_file
    end

    def dev_box_url
      @data['dev_box_url']
    end

    def dev_project_path
      @data['dev_project_path']
    end

    def dev_ram
      @data['dev_ram']
    end

    def dev_num_cpu
      @data['dev_num_cpu']
    end

    def dev_cpu_cap
      @data['dev_cpu_cap']
    end

    def dev_dns_patterns
      @data['dev_dns_patterns']
    end

    def dev_dns_tlds
      @data['dev_dns_tlds']
    end

    def data
      @data
    end

    def empty?
      @data == default_structure
    end

    def load_file
      require 'yaml'
      YAML.load_file(@path)
    rescue Errno::ENOENT
      default_structure
    end

    def path=(path)
      @path = path
      @data = load_file
      @path
    end

    def reset
      self.send(:initialize)
    end

    private

    def default_structure
      {
        'dev_box_url'       => '',
        'dev_project_path'  => '',
        'dev_ram'           => '',
        'dev_num_cpu'       => '',
        'dev_cpu_cap'       => '',
        'dev_dns_tlds'      => '',
        'dev_dns_patterns'  => ''
      }
    end
  end
end

$platforms = Platforms::Config.instance

Vagrant.configure("2") do |config|
  ## VOCEPLATFORMS DEVELOPMENT
  config.vm.define "development.voceplatforms.com" do |vd|
    ## VOCEPLATFORMS DEVELOPMENT BOX SETTINGS
    vd.vm.box = "development.voceplatforms.com"
    vd.vm.box_url = "#{$platforms.dev_box_url}"
    vd.vm.hostname = "development.voceplatforms.com"

    ## VOCEPLATFORMS DEVELOPMENT SYNCED FOLDERS
    vd.vm.synced_folder ".", "/opt/ansible", :nfs => true
    vd.vm.synced_folder "#{$platforms.dev_project_path}", "/vagrant-nfs", :nfs => true, :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']
    vd.bindfs.bind_folder "/vagrant-nfs", "/nfs", :perms => "u=rwX:g=rwX:o=rxD", :group => "www-data"

    ## VOCEPLATFORMS DEVELOPMENT NETWORK/SSH SETTINGS
    vd.ssh.private_key_path = "#{ENV['HOME']}/.ssh/vagrant"
    vd.ssh.forward_agent    = true
    vd.vm.network :private_network, ip: "192.168.33.10"

    tlds = ['dev']

    ## ADD SUPPORT FOR CUSTOM TLDS AND PATTERNS
    begin
      if $platforms.dev_dns_tlds && $platforms.dev_dns_tlds.any?
        $platforms.dev_dns_tlds.each do |tld|
          tlds << tld
        end
      end
    rescue NoMethodError => e
      puts "'dev_dns_tlds' in your 'virtualbox-settings' file should be an array!"
      exit 1
    rescue
      puts "an error occurred processing 'dev_dns_tlds'!"
      exit 1
    end

    vd.dns.tlds = tlds.uniq

    patterns = [/^.*voceconnect.dev$/, /^.*playstation.dev$/]

    begin
      if $platforms.dev_dns_patterns && $platforms.dev_dns_patterns.any?
        $platforms.dev_dns_patterns.each do |p|
          pattern = Regexp.new p
          patterns << pattern
        end
      end
    rescue NoMethodError => e
      puts "'dev_dns_patterns' in your 'virtualbox-settings' file should be an array!"
      exit 1
    rescue
      puts "an error occurred processing 'dev_dns_patterns'!"
      exit 1
    end

    vd.dns.patterns = patterns.uniq

    ## VOCEPLATFORMS DEVELOPMENT VM SETTINGS
    vd.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "development.voceplatforms.com"

      vb.customize ["modifyvm", :id, "--memory", $platforms.dev_ram]
      vb.customize ["modifyvm", :id, "--cpus", $platforms.dev_num_cpu]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", $platforms.dev_cpu_cap]
    end

    ## VOCEPLATFORMS PROVISIONER
    vd.vm.provision :ansible do |s|
      s.playbook       = "development.yml"
      s.inventory_path = "inventory/development"
    end
  end
end
