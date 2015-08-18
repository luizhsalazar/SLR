class AcmsController < ApplicationController
  before_action :set_acm, only: [:show, :edit, :update, :destroy]

  # GET /acms
  # GET /acms.json
  def index
    @acms = Acm.all
  end

  # GET /acms/new
  def new
    @acm = current_user.acms.build
  end

  def create
    @acm = Acm.new
    @acm = @acm.search(params[:protocol][:query])

    redirect_to references_path
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
