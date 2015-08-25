require 'open-uri'

class Scidir < ActiveRecord::Base

  def search(query, protocol_id)

    doc = Nokogiri::XML(open("http://api.elsevier.com/content/search/index:SCIDIR?apikey=2fc5e714431bca9f441f4314c6684282&httpAccept=application%2Fatom%2Bxml&count=100&query=" + query))

    @logger = Logger.new("SLR.log")

    doc.xpath("//xmlns:entry").each do|entry|

      @scidir = Scidir.new

      entry.xpath("./*").each do |element|
        if element.name == 'title'
          @scidir.title = element.text
          title = @scidir.title
        end
        if element.name == 'creator'
          @scidir.author = element.text
        end
        if element.name == 'teaser'
          @scidir.abstract = element.text
        end
        if element.name == 'publicationName'
          @scidir.pubtitle = element.text
        end

        if element.name == 'link'
          if element["ref"] == 'scidir'
            @scidir.link = element["href"]
          end
        end
      end

      @scidir.save!
    end

    results = Scidir.all.length

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'Science Direct')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'Science Direct'

    unless @reference.results == results
      @reference.results = results
    end

    @reference.save!
  end

end
