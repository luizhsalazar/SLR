class IeeesController < ApplicationController

  # Show all references from IEEE library
  def index
    @ieees = Ieee.all
  end

  def new
    @ieee = current_user.ieees.build
  end

  def create

    @ieee = Ieee.new
    @ieee = @ieee.search(params[:protocol][:query])

    redirect_to references_path
  end


end
