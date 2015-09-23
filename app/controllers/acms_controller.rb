class AcmsController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  def show
    @acms = Acm.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @acm = Acm.find(params[:id])

    @included = Included.new
    @included.title = @acm.title
    @included.author = @acm.author
    @included.pubtitle = @acm.pubtitle
    @included.protocol_id = @acm.protocol_id
    @included.link = @acm.link
    @included.name_database = 'acm'
    @included.included = 0
    @included.save!

    @acm.destroy

    redirect_to :back
  end

  def unselect
    @acm = Acm.find(params[:id])
    @acm.destroy

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
