class GoogleScholar < ActiveRecord::Base

  def search(query, protocol_id)

    doc = Nokogiri::HTML(open("http://scholar.google.com.br/scholar?q=" + query))

    @logger = Logger.new("SLR.log")

    titles = doc.css("h3.gs_rt").children

    titles.each { |title|
      @logger.debug "Doc: #{title.child}"
      @logger.debug "Doc: #{title['href']}"
      @logger.debug "--------------------------------------------------------"
    }

    # links = doc.css("a.medium-text")
    # links.each { |link|
    #
    #   @acm = Acm.new
    #
    #   @acm.title = link.child
    #   @acm.link = 'http://dl.acm.org/' + link['href']
    #
    #   @acm.protocol_id = protocol_id
    #   @acm.save!
    #
    #   # @logger.debug "Title: #{link.child}"
    #   # @logger.debug "Link: #{link['href']}"
    #   # @logger.debug "----------------------------------------------------"
    # }
    #
    # results =  Acm.where("protocol_id = ?", protocol_id).count
    #
    # @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'ACM Digital Library')
    #
    # @reference.protocol_id = protocol_id
    # @reference.database_name = 'ACM Digital Library'
    # @reference.database = 'acm'
    #
    # @reference.results = results
    #
    # @reference.save!

  end

end
