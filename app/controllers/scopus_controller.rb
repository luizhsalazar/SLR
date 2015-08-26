class ScopusController < ApplicationController
  before_action :set_scopu, only: [:show, :edit, :update, :destroy]

  # GET /scopus
  # GET /scopus.json
  def index
    @scopus = Scopu.all
  end

  # GET /scopus/1
  # GET /scopus/1.json
  def show
  end

  # GET /scopus/new
  def new
    @scopu = current_user.scopus.build
  end

  # GET /scopus/1/edit
  def edit
  end

  # POST /scopus
  # POST /scopus.json
  def create
    protocol_id = params[:protocol][:id]
    @scopu = Scopu.new
    @scopu = @scopu.search(params[:protocol][:query], protocol_id)

    redirect_to reference_url(protocol_id)
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
