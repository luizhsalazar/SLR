class IncludedsController < ApplicationController
  before_action :set_included, only: [:show, :edit, :update, :destroy]

  def include
    @included = Included.find(params[:id])
    @included.included = 1
    @included.save!

    redirect_to :back
  end

  def exclude
    @included = Included.find(params[:id])
    @included.destroy

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_included
      @included = Included.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def included_params
      params.require(:included).permit(:title, :author, :pubtitle, :included, :protocol_id)
    end
end
