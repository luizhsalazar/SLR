class IeeesController < ApplicationController

  # Show all references from IEEE library
  def index
    @ieees = Ieee.all
  end

  def new
    @ieee = current_user.ieees.build
  end

  def create

    protocol_id = params[:protocol][:id]
    @ieee = Ieee.new
    @ieee = @ieee.search(params[:protocol][:query], protocol_id)

    # redirect_to reference_url(protocol_id)

    redirect_to references_path

  end


end
