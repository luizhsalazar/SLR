class IeeesController < ApplicationController

  # Show all references from IEEE library
  def index
    @ieees = Ieee.all
  end

  def new
    @ieee = current_user.ieees.build
  end

  def create

    query = params[:protocol][:query]

    @ieee = Ieee.new
    @ieee = @ieee.search_ieee(query)

    redirect_to ieees_path

  end


end
