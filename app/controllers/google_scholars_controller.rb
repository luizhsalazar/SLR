class GoogleScholarsController < ApplicationController
  before_action :set_google_scholar, only: [:show, :edit, :update, :destroy]

  # GET /google_scholars
  # GET /google_scholars.json
  def index
    @google_scholars = GoogleScholar.all
  end

  # GET /google_scholars/1
  # GET /google_scholars/1.json
  def show
    @google_scholar = GoogleScholar.where("protocol_id = ?", params[:id])
  end

  # GET /google_scholars/new
  def new
    @google_scholar = current_user.google_scholars.build
  end

  # GET /google_scholars/1/edit
  def edit
  end

  # POST /google_scholars
  # POST /google_scholars.json
  def create
    @google_scholar = GoogleScholar.new(google_scholar_params)

    respond_to do |format|
      if @google_scholar.save
        format.html { redirect_to @google_scholar, notice: 'Google scholar was successfully created.' }
        format.json { render :show, status: :created, location: @google_scholar }
      else
        format.html { render :new }
        format.json { render json: @google_scholar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /google_scholars/1
  # PATCH/PUT /google_scholars/1.json
  def update
    respond_to do |format|
      if @google_scholar.update(google_scholar_params)
        format.html { redirect_to @google_scholar, notice: 'Google scholar was successfully updated.' }
        format.json { render :show, status: :ok, location: @google_scholar }
      else
        format.html { render :edit }
        format.json { render json: @google_scholar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /google_scholars/1
  # DELETE /google_scholars/1.json
  def destroy
    @google_scholar.destroy
    respond_to do |format|
      format.html { redirect_to google_scholars_url, notice: 'Google scholar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_google_scholar
      @google_scholar = GoogleScholar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def google_scholar_params
      params.require(:google_scholar).permit(:abstract, :author, :link, :publisher, :pubtitle, :pubtype, :title, :protocol_id, :included, :selected)
    end
end
