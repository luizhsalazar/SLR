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
  end

  # GET /protocols/new
  def new
    @protocol = current_user.protocols.build
    1.times { @protocol.terms.build }
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
      termos += (index == attributes.size - 1) ? '("' + term[:termo] + '" OR "' + term[:sinonimo] + '" OR "' + term[:sinonimo2] + '" OR "' + term[:sinonimo3] + '" OR "' + term[:traducao] + '")' : '("' + term[:termo] + '" OR "' + term[:sinonimo] + '" OR "' + term[:sinonimo2] + '" OR "' + term[:sinonimo3] + '" OR "' + term[:traducao] + '")' + ' AND '
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
    @ref_protocol = reference_exist
  end

  def do_search
    @protocol = Protocol.find(params[:id])

    @protocol.clean_bases(params[:id])

    from = params[:from]
    to = params[:to]
    query = params[:protocol][:query]
    protocol_id = params[:id]
    max_results = params[:protocol][:results_returned]

    if @protocol.ieee
      @ieee = Ieee.new
      @ieee = @ieee.search(query, protocol_id, max_results, from, to)
    end

    if @protocol.scopus
      @scopu = Scopu.new
      @scopu = @scopu.search(query, protocol_id, max_results, from, to)
    end

    if @protocol.science_direct
      @scidir = Scidir.new
      @scidir = @scidir.search(query, protocol_id, max_results, from, to)
    end

    if @protocol.acm
      @acm = Acm.new
      @acm = @acm.search(query, protocol_id, max_results, from, to)
    end

    redirect_to reference_url(protocol_id)

  end

  def selected
    @protocol = Protocol.find(params[:id])

    @selected_ieee = []
    @selected_scidir = []
    @selected_scopus = []
    @selected_acm = []

    if @protocol.ieee
      Ieee.where("protocol_id = ?", params[:id]).each { |ieee|
        unless ieee.selected.nil?
          @selected_ieee.push(ieee)
        end
      }
    end

    if @protocol.science_direct
      Scidir.where("protocol_id = ?", params[:id]).each { |scidir|
        unless scidir.selected.nil?
          @selected_scidir.push(scidir)
        end
      }
    end

    if @protocol.scopus
      Scopu.where("protocol_id = ?", params[:id]).each { |scopus|
        unless scopus.selected.nil?
          @selected_scopus.push(scopus)
        end
      }
    end

    if @protocol.acm
      Acm.where("protocol_id = ?", params[:id]).each { |acm|
        unless acm.selected.nil?
          @selected_acm.push(acm)
        end
      }
    end

    @empty_ieee = (@selected_ieee.empty?) ? true : false
    @empty_scidir = (@selected_scidir.empty?) ? true : false
    @empty_scopus = (@selected_scopus.empty?) ? true : false
    @empty_acm = (@selected_acm.empty?) ? true : false

    @ref_protocol = reference_exist
  end

  def included
    @protocol = Protocol.find(params[:id])

    @included_ieee = []
    @included_scidir = []
    @included_scopus = []
    @included_acm = []

    if @protocol.ieee
      Ieee.where("protocol_id = ?", params[:id]).each { |ieee|
        unless ieee.included.nil?
          @included_ieee.push(ieee)
        end
      }
    end

    if @protocol.science_direct
      Scidir.where("protocol_id = ?", params[:id]).each { |scidir|
        unless scidir.included.nil?
          @included_scidir.push(scidir)
        end
      }
    end

    if @protocol.scopus
      Scopu.where("protocol_id = ?", params[:id]).each { |scopus|
        unless scopus.included.nil?
          @included_scopus.push(scopus)
        end
      }
    end

    if @protocol.acm
      Acm.where("protocol_id = ?", params[:id]).each { |acm|
        unless acm.included.nil?
          @included_acm.push(acm)
        end
      }
    end

    @empty_ieee = (@included_ieee.empty?) ? true : false
    @empty_scidir = (@included_scidir.empty?) ? true : false
    @empty_scopus = (@included_scopus.empty?) ? true : false
    @empty_acm = (@included_acm.empty?) ? true : false

    @ref_protocol = reference_exist
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_protocol
      @protocol = Protocol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def protocol_params
      params.require(:protocol).permit(:id, :title, :background, :research_question, :strategy, :criteria, :from, :to, :results_returned,
                                       :ieee, :acm, :springer, :science_direct, :google_scholar, :scopus, :quality,
                                       :terms_attributes => [:id, :termo, :sinonimo, :sinonimo2, :sinonimo3, :traducao])
    end

    # Verifica se alguma busca já foi realizada para aquele protocolo
    def reference_exist
      Reference.find_by_protocol_id(params[:id])
    end

end
