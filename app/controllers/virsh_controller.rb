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
end
