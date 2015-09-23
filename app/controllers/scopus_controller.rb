class ScopusController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]

  # GET /scopus/1
  # GET /scopus/1.json
  def show
    @scopus = Scopu.where("protocol_id = ?", params[:id]).paginate(:page => params[:page], per_page: 10)
    @reference = Reference.find_by_protocol_id(params[:id])
  end

  def select
    @scopu = Scopu.find(params[:id])

    @included = Included.new
    @included.title = @scopu.title
    @included.author = @scopu.author
    @included.pubtitle = @scopu.pubtitle
    @included.protocol_id = @scopu.protocol_id
    @included.link = @scopu.link
    @included.name_database = 'scopus'
    @included.included = 0
    @included.save!

    @scopu.destroy

    redirect_to :back
  end

  def unselect
    @scopu = Scopu.find(params[:id])
    @scopu.destroy

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
