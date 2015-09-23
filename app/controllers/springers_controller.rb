class SpringersController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  def show
    @springers = Springer.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @springer = Springer.find(params[:id])

    @included = Included.new
    @included.title = @springer.title
    @included.author = @springer.author
    @included.pubtitle = @springer.pubtitle
    @included.protocol_id = @springer.protocol_id
    @included.link = @springer.link
    @included.name_database = 'springer'
    @included.included = 0
    @included.save!

    @springer.destroy

    redirect_to :back
  end

  def unselect
    @springer = Springer.find(params[:id])
    @springer.destroy

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
