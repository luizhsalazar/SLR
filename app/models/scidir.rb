require 'open-uri'

class Scidir < ActiveRecord::Base

  def search(query, protocol_id, max_returned, from, to)

    doc = Nokogiri::XML(open('http://api.elsevier.com/content/search/scidir?apikey=2fc5e714431bca9f441f4314c6684282&httpAccept=application%2Fatom%2Bxml&count=' + max_returned + '&query=' + query + '&date=' + from + '-' + to))

    doc.xpath("//opensearch:totalResults").each do |entry|
      @total_found = entry.text
    end

    doc.xpath("//xmlns:entry").each do|entry|

      @scidir = Scidir.new

      entry.xpath("./*").each do |element|
        if element.name == 'title'
          @scidir.title = element.text
        end
        if element.name == 'creator'
          @scidir.author = element.text
        end
        if element.name == 'teaser'
          @scidir.abstract = element.text.empty? ? 'Abstract não disponível' : element.text
        end
        if element.name == 'publicationName'
          @scidir.pubtitle = element.text
        end

        if element.name == 'link'
          if element["ref"] == 'scidir'
            @scidir.link = element["href"]
          end
        end

        if element.name == 'coverDate'
          @scidir.year = element.text[0..3]
        end

      end

      @scidir.protocol_id = protocol_id

      @scidir.save!
    end

    results =  Scidir.where("protocol_id = ?", protocol_id).count

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'Science Direct')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'Science Direct'
    @reference.database = 'scidir'

    @reference.results = results
    @reference.total_found = @total_found

    @reference.save!
  end

end
