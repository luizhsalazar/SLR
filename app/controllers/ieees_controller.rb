class IeeesController < ApplicationController

  # Show all references from IEEE library
  def index
    @ieees = Ieee.all
  end

  def new
    @ieee = current_user.ieees.build
  end

  def show
    #fixme: Ajustar para buscar apenas as referências da IEEE daquele protocolo, não de todos como está fazendo agora.
    @ieees = Ieee.all
  end

  def create
    protocol_id = params[:protocol][:id]
    @ieee = Ieee.new
    @ieee = @ieee.search(params[:protocol][:query], protocol_id)

    redirect_to reference_url(protocol_id)
  end

  def include
    @ieee = Ieee.find(params[:id])
    @ieee.included = 1
    @ieee.save!
    redirect_to :back
  end

  def exclude
    @ieee = Ieee.find(params[:id])
    @ieee.included = nil
    @ieee.save!
    redirect_to :back
  end


end
