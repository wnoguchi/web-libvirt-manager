class VirshController < ApplicationController
  def index
    @domain_list_str = `sudo virsh list --all`
    @count = -2
    @domain_list = []
    @domain_name_list = []
    @domain_list_str.each_line do |line|
      @count += 1
      next if @count <= 0
      next if line.chomp.empty?
#      @domain_list << line.chomp
      line =~ /([\d-]+) +([\w_]+) +(.+)/
      @domain_list << {
        :id => $1,
        :domain_name => $2,
        :status => $3,
      }
      @domain_name_list << [ $2, $2 ]
    end
    logger.debug @domain_list.to_yaml
  end

  def start
    domain = params[:domain]
    `sudo virsh start #{domain}`
    redirect_to root_path
  end

  def suspend
    domain = params[:domain]
    `sudo virsh suspend #{domain}`
    redirect_to :action => :index
  end

  def resume
    domain = params[:domain]
    `sudo virsh resume #{domain}`
    redirect_to root_path
  end

  def reboot
    domain = params[:domain]
    `sudo virsh reboot #{domain}`
    redirect_to root_path
  end

  def shutdown
    domain = params[:domain]
    `sudo virsh shutdown #{domain}`
    redirect_to root_path
  end

  def clone
    from = params[:from]
    to = params[:to]
    command = "sudo virt-clone --original #{from} --name #{to} --file /var/lib/libvirt/images/#{to}.img"
    result = `#{command} &`
    logger.debug command
    logger.debug result
    redirect_to root_path
  end

  def domstate
    
  end
  
end
