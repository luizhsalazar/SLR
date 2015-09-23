class IeeesController < ApplicationController

  def show
    @ieees = Ieee.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @ieee = Ieee.find(params[:id])

    @included = Included.new
    @included.title = @ieee.title
    @included.author = @ieee.author
    @included.pubtitle = @ieee.pubtitle
    @included.protocol_id = @ieee.protocol_id
    @included.link = @ieee.link
    @included.name_database = 'ieee'
    @included.included = 0
    @included.save!

    @ieee.destroy

    redirect_to :back
  end

  def unselect
    @ieee = Ieee.find(params[:id])
    @ieee.destroy

    redirect_to :back
  end

end
