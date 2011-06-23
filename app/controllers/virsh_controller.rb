class VirshController < ApplicationController
  def index
    @domain_list_str = `sudo virsh list --all`
    @count = -2
    @domain_list = []
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
    end
    logger.debug @domain_list.to_yaml
  end

  def start
    domain = params[:domain]
    `sudo virsh start #{domain}`
    redirect_to :action => :index
  end

  def suspend
    domain = params[:domain]
    `sudo virsh suspend #{domain}`
    redirect_to :action => :index
  end

  def resume
    domain = params[:domain]
    `sudo virsh resume #{domain}`
    redirect_to :action => :index
  end

  def reboot
    domain = params[:domain]
    `sudo virsh reboot #{domain}`
    redirect_to :action => :index
  end

  def shutdown
    domain = params[:domain]
    `sudo virsh shutdown #{domain}`
    redirect_to :action => :index
  end

end
