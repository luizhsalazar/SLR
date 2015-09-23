class ScidirsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  def show
    @scidirs = Scidir.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @scidir = Scidir.find(params[:id])

    @included = Included.new
    @included.title = @scidir.title
    @included.author = @scidir.author
    @included.pubtitle = @scidir.pubtitle
    @included.protocol_id = @scidir.protocol_id
    @included.link = @scidir.link
    @included.name_database = 'scidir'
    @included.included = 0
    @included.save!

    @scidir.destroy

    redirect_to :back
  end

  def unselect
    @scidir = Scidir.find(params[:id])
    @scidir.destroy

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
