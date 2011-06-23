class VirshController < ApplicationController
  def index
    @domain_list_str = `sudo virsh list --all`
    @count = -2
    @domain_list = []
    @domain_list_str.each_line do |line|
      @count += 1
      next if @count <= 0
      @domain_list << line.chomp
    end
  end
end
