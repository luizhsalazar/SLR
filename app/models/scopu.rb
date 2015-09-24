class Scopu < ActiveRecord::Base

  def search(query, protocol_id, max_returned, from, to)

    doc = Nokogiri::XML(open('http://api.elsevier.com/content/search/scopus?apikey=2fc5e714431bca9f441f4314c6684282&httpAccept=application%2Fatom%2Bxml&view=complete&count=' + max_returned + '&query=' + query + '&date=' + from + '-' + to))

    doc.xpath("//opensearch:totalResults").each do |entry|
      @total_found = entry.text
    end

    doc.xpath("//xmlns:entry").each do|entry|

      @scopu = Scopu.new

      entry.xpath("./*").each do |element|

        if element.name == 'error'
          # Nenhum resultado retornou da busca
          @results = 0
        else
          if element.name == 'title'
            @scopu.title = element.text
          end
          if element.name == 'creator'
            @scopu.author = element.text
          end
          if element.name == 'description'
            @scopu.abstract = element.text
          end
          if element.name == 'publicationName'
            @scopu.pubtitle = element.text
          end

          if element.name == 'link'
            if element["ref"] == 'scopus'
              @scopu.link = element["href"]
            end
          end

          if element.name == 'coverDate'
            @scopu.year = element.text[0..3]
          end
        end
      end

      @scopu.protocol_id = protocol_id

      @scopu.save!
    end

    unless @results == 0
      @results =  Scopu.where("protocol_id = ?", protocol_id).count
    end

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'Scopus')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'Scopus'
    @reference.database = 'scopu'

    @reference.results = @results
    @reference.total_found = @total_found

    @reference.save!
  end

end
