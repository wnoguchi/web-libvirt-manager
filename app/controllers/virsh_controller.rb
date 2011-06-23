class VirshController < ApplicationController
  def index
    @result = `sudo virsh list --all`
#    @result = `id`
  end

end
