class ScopusController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /scopus
  # GET /scopus.json
  def index
    @scopus = Scopu.all
  end

  # GET /scopus/1
  # GET /scopus/1.json
  def show
    @scopus = Scopu.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
  end

  # GET /scopus/new
  def new
    @scopu = current_user.scopus.build
  end

  # GET /scopus/1/edit
  def edit
  end

  def include
    @scopu = Scopu.find(params[:id])
    @scopu.included = 1
    @scopu.save!
    redirect_to :back
  end

  def exclude
    @scopu = Scopu.find(params[:id])
    @scopu.included = nil
    @scopu.save!
    redirect_to :back
  end

  def select
    @scopu = Scopu.find(params[:id])
    @scopu.selected = 1
    @scopu.save!
    redirect_to :back
  end

  def unselect
    @scopu = Scopu.find(params[:id])
    @scopu.selected = nil
    @scopu.included = nil
    @scopu.save!
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scopu
      @scopu = Scopu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scopu_params
      params.require(:scopu).permit(:abstract, :author, :link, :publisher, :pubtitle, :pubtype, :title)
    end
end
