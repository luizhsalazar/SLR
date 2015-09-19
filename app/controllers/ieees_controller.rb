class IeeesController < ApplicationController

  # Show all references from IEEE library
  def index
    @ieees = Ieee.all
  end

  def new
    @ieee = current_user.ieees.build
  end

  def show
    @ieees = Ieee.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)

  end

  def include
    @ieee = Ieee.find(params[:id])
    @ieee.included = 1
    @ieee.save!
    redirect_to :back
  end

  def exclude
    @ieee = Ieee.find(params[:id])
    @ieee.included = nil
    @ieee.save!
    redirect_to :back
  end

  def select
    @ieee = Ieee.find(params[:id])
    @ieee.selected = 1
    @ieee.save!
    redirect_to :back
  end

  def unselect
    @ieee = Ieee.find(params[:id])
    @ieee.selected = nil
    @ieee.included = nil
    @ieee.save!
    redirect_to :back
  end


end
