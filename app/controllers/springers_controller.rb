class SpringersController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /springers
  # GET /springers.json
  def index
    @springers = Springer.all
  end

  # GET /springers/1
  # GET /springers/1.json
  def show
    @springers = Springer.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
  end

  # GET /springers/new
  def new
    @springer = current_user.springers.build
  end

  def include
    @springer = Springer.find(params[:id])
    @springer.included = 1
    @springer.selected = nil
    @springer.save!
    redirect_to :back
  end

  def exclude
    @springer = Springer.find(params[:id])
    @springer.included = nil
    @springer.save!
    redirect_to :back
  end

  def select
    @springer = Springer.find(params[:id])
    @springer.selected = 1
    @springer.save!
    redirect_to :back
  end

  def unselect
    @springer = Springer.find(params[:id])
    @springer.selected = nil
    @springer.included = nil
    @springer.save!
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_springer
      @springer = Springer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def springer_params
      params.require(:springer).permit(:abstract, :author, :link, :publisher, :pubtitle, :pubtype, :title, :protocol_id, :included, :selected)
    end
end
