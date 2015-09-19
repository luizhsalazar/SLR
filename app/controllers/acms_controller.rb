class AcmsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /acms
  # GET /acms.json
  def index
    @acms = Acm.all
  end

  def show
    @acms = Acm.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
  end

  # GET /acms/new
  def new
    @acm = current_user.acms.build
  end

  def include
    @acm = Acm.find(params[:id])
    @acm.included = 1
    @acm.save!
    redirect_to :back
  end

  def exclude
    @acm = Acm.find(params[:id])
    @acm.included = nil
    @acm.save!
    redirect_to :back
  end

  def select
    @acm = Acm.find(params[:id])
    @acm.selected = 1
    @acm.save!
    redirect_to :back
  end

  def unselect
    @acm = Acm.find(params[:id])
    @acm.selected = nil
    @acm.included = nil
    @acm.save!
    redirect_to :back
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acm
      @acm = Acm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acm_params
      params.require(:acm).permit(:abstract, :author, :generic_string, :link, :publisher, :pubtitle, :pubtype, :title)
    end
end
