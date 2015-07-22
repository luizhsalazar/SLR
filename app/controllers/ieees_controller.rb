require 'mechanize'
require 'nokogiri'
require 'rexml/document'
require 'open-uri'

class IeeesController < ApplicationController

  # Show all references from IEEE library
  def index
    @ieee = find.all()
  end

  def new
    @ieee = Ieee.new
  end

  def create
    @ieee = Ieee.new(allowed_params)

    if @ieee.save
      redirect_to ieees_path
    else
      render 'new'
    end
  end

  # Show one specific reference
  def show
    self.search(params[:string])
    # @ieee_reference = params[:ieee]
  end

  def search(string)
      # queryurl = 'http://ieeexplore.ieee.org/gateway/ipsSearch.jsp?querytext=(' + string.to_s + ')'

      doc = Nokogiri.parse open('http://www.w3schools.com/xml/note.xml')

      @note = OpenStruct.new

      @note.to = doc.at('to').text
      @note.from = doc.at('from').text
      @note.heading = doc.at('heading').text
      @note.body = doc.at('body').text

      if @note.save
        redirect_to ieees_path
      else
        render 'home/index'
      end
  end

  private
    def allowed_params
      params.require(:ieee).permit(:string)
    end

end
