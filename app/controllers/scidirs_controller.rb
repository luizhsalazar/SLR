class ScidirsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /scidirs
  # GET /scidirs.json
  def index
    @scidirs = Scidir.all
  end

  # GET /scidirs/1
  # GET /scidirs/1.json
  def show
    @scidirs = Scidir.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
  end

  # GET /scidirs/new
  def new
    @scidir = current_user.scidirs.build
  end

  # GET /scidirs/1/edit
  def edit
  end

  def include
    @scidir = Scidir.find(params[:id])
    @scidir.included = 1
    @scidir.save!
    redirect_to :back
  end

  def exclude
    @scidir = Scidir.find(params[:id])
    @scidir.included = nil
    @scidir.save!
    redirect_to :back
  end

  def select
    @scidir = Scidir.find(params[:id])
    @scidir.selected = 1
    @scidir.save!
    redirect_to :back
  end

  def unselect
    @scidir = Scidir.find(params[:id])
    @scidir.selected = nil
    @scidir.included = nil
    @scidir.save!
    redirect_to :back
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scidir
      @scidir = Scidir.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scidir_params
      params.require(:scidir).permit(:abstract, :author, :generic_string, :link, :publisher, :pubtitle, :pubtype, :title)
    end
end
