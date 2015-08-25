class ScidirsController < ApplicationController
  before_action :set_scidir, only: [:show, :edit, :update, :destroy]

  # GET /scidirs
  # GET /scidirs.json
  def index
    @scidirs = Scidir.all
  end

  # GET /scidirs/1
  # GET /scidirs/1.json
  def show
  end

  # GET /scidirs/new
  def new
    @scidir = current_user.scidirs.build
  end

  # GET /scidirs/1/edit
  def edit
  end

  # POST /scidirs
  # POST /scidirs.json
  def create
    protocol_id = params[:protocol][:id]
    @scidir = Scidir.new
    @scidir = @scidir.search(params[:protocol][:query], protocol_id)

    redirect_to reference_url(protocol_id)
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
