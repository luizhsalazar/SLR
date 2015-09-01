class ProtocolsController < ApplicationController
  before_action :set_protocol, only: [:show, :edit, :update, :destroy]

  # GET /protocols
  # GET /protocols.json
  def index
    @protocols = Protocol.all
  end

  # GET /protocols/1
  # GET /protocols/1.json
  def show

      @included = []

      Ieee.where("protocol_id = ?", params[:id]).each { |ieee|
        unless ieee.included.nil?
          @included.push(ieee)
        end
      }
  end

  # GET /protocols/new
  def new
    @protocol = current_user.protocols.build
    2.times { @protocol.terms.build }
  end

  # GET /protocols/1/edit
  def edit
  end

  # POST /protocols
  # POST /protocols.json
  def create
    @protocol = current_user.protocols.build(protocol_params)
    termos = ''
    attributes = protocol_params[:terms_attributes]
    attributes.values.each_with_index do |term, index|
      termos += (index == attributes.size - 1) ? '(' + term[:termo] + ' OR ' + term[:sinonimo] + ' OR ' + term[:traducao] + ' ) ' : '(' + term[:termo] + ' OR ' + term[:sinonimo] + ' OR ' + term[:traducao] + ' ) ' + ' AND '
    end

    @protocol.query = termos

    respond_to do |format|
      if @protocol.save
        format.html { redirect_to @protocol, notice: 'Protocol was successfully created.' }
        format.json { render :show, status: :created, location: @protocol }
      else
        format.html { render :new }
        format.json { render json: @protocol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /protocols/1
  # PATCH/PUT /protocols/1.json
  def update

    termos = ''
    attributes = protocol_params[:terms_attributes]
    attributes.values.each_with_index do |term, index|
      termos += (index == attributes.size - 1) ? '(' + term[:termo] + ' OR ' + term[:sinonimo] + ' OR ' + term[:traducao] + ' ) ' : '(' + term[:termo] + ' OR ' + term[:sinonimo] + ' OR ' + term[:traducao] + ' ) ' + ' AND '
    end

    @protocol.query = termos

    respond_to do |format|
      if @protocol.update(protocol_params)
        format.html { redirect_to @protocol, notice: 'Protocol was successfully updated.' }
        format.json { render :show, status: :ok, location: @protocol }
      else
        format.html { render :edit }
        format.json { render json: @protocol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /protocols/1
  # DELETE /protocols/1.json
  def destroy
    @protocol.destroy
    respond_to do |format|
      format.html { redirect_to protocols_url, notice: 'Protocol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @protocol = Protocol.find(params[:id])
  end

  def do_search
    # @protocol = Protocol.find(params[:id])
    #
    # if @protocol.scopus
    #   redirect_to scopus_path(params[:id], params[:query])
    # end
    # if @protocol.ieee
    #   redirect_to ieees_path
    # end
    # if @protocol.science_direct
    #   redirect_to scidirs_path
    # end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_protocol
      @protocol = Protocol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def protocol_params
      params.require(:protocol).permit(:id, :title, :background, :research_question, :strategy, :criteria, :from, :to,
                                       :ieee, :acm, :springer, :science_direct, :google_scholar, :scopus, :quality,
                                       :terms_attributes => [:id, :termo, :sinonimo, :traducao])
    end
end
