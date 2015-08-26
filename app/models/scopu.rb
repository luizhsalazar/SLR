class Scopu < ActiveRecord::Base

  def search(query, protocol_id)

    doc = Nokogiri::XML(open("http://api.elsevier.com/content/search/scopus?apikey=2fc5e714431bca9f441f4314c6684282&httpAccept=application%2Fatom%2Bxml&query=" + query))

    @logger = Logger.new("SLR.log")

    @logger.debug "DOC: #{doc}"

    doc.xpath("//xmlns:entry").each do|entry|

      @scopu = Scopu.new

      entry.xpath("./*").each do |element|
        if element.name == 'title'
          @scopu.title = element.text
        end
        if element.name == 'creator'
          @scopu.author = element.text
        end
        if element.name == 'teaser'
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
      end

      @scopu.save!
    end

    results = Scopu.all.length

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'Scopus')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'Scopus'

    unless @reference.results == results
      @reference.results = results
    end

    @reference.save!
  end

end
