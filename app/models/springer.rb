class Springer < ActiveRecord::Base

  def search(query, protocol_id, max_returned, from, to)

    doc = Nokogiri::XML(open('http://api.springer.com/metadata/pam?api_key=df81deec5097211838ef3a07c91c02d2&q=' + query + '&p=' + max_returned))

    @logger = Logger.new("SLR.log")

    doc.xpath("//response//result/*").each do|entry|
      if entry.name == 'total'
        @total_found = entry.text
      end
    end

    doc.xpath("//response//records/*").each do|entry|

      @springer = Springer.new

      entry.xpath("./*/*/*").each do |element|

        if element.name == 'title'
          @logger.debug "Title: #{element.text}"
          @springer.title = element.text
        end

        if element.name == 'creator'
          @logger.debug "Author: #{element.text}"
          @springer.author = element.text
        end

        if element.name == 'publicationName'
          @logger.debug "Pubtitle: #{element.text}"
          @springer.pubtitle = element.text
        end

        if element.name == 'url'
          @logger.debug "Link: #{element.text}"
          @springer.link = element.text
        end

      end

      @springer.protocol_id = protocol_id
      @springer.save!

    end

    results =  Springer.where("protocol_id = ?", protocol_id).count

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'Springer')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'Springer Link'
    @reference.database = 'springer'

    @reference.results = results
    @reference.total_found = @total_found

    @reference.save!
  end
end
