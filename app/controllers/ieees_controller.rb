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

    respond_to do |format|
      # if @ieee.save
        format.html { redirect_to ieees_path }
      # else
      #   format.html { render :new }
      #   format.json { render json: @ieee.errors, status: :unprocessable_entity }
      # end
    end
  end


end
