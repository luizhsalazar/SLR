class Acm < ActiveRecord::Base

  def search(query, protocol_id, max_results, from, to)

    max = max_results.to_f / 20

    j = 1

    doc = Nokogiri::HTML(open("http://dl.acm.org/results.cfm?within=" + query))

    doc_total = doc.css("table.small-text td")

    # Search for last characters and remove comma to get the total found value
    total_found = doc_total.first.child.to_s[18..-1].gsub(/,/, '').to_f

    @logger = Logger.new("SLR2.log")

    index = 0

    for i in 1..max

      search_query = "http://dl.acm.org/results.cfm?within=" + query + "&start=" + j.to_s

      doc = Nokogiri::HTML(open(search_query))

      # Result comes with 20 references per page
      j += 20

      links = doc.css("a.medium-text")
      abstracts = doc.css("div.abstract2")
      conference = doc.css("div.addinfo")
      authors = doc.css("div.authors")

      links.each { |link|

        @acm = Acm.new
        @acm.title = link.child
        @acm.link = 'http://dl.acm.org/' + link['href']

        # Stripping HTML tags and deleting undesirable symbols
        @acm.pubtitle = ActionView::Base.full_sanitizer.sanitize(conference[index].to_s).strip.gsub(/&#13;/, '')
        @acm.abstract = ActionView::Base.full_sanitizer.sanitize(abstracts[index].to_s).strip.gsub(/&#13;/, '')
        @acm.author = ActionView::Base.full_sanitizer.sanitize(authors[index].to_s).strip.gsub(/&#13;/, '')

        @acm.protocol_id = protocol_id
        @acm.save!

        # @logger.debug "Title: #{link.child}"
        # @logger.debug "Link: #{link['href']}"
        # @logger.debug "PubTitle: #{conference[index].to_s}"
        # @logger.debug "Abstract: #{abstracts[index].to_s}"
        # @logger.debug "Author: #{authors[index].to_s}"
        # @logger.debug "----------------------------------------------------"

        index += 1
      }
    end

    results =  Acm.where("protocol_id = ?", protocol_id).count

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'ACM Digital Library')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'ACM Digital Library'
    @reference.database = 'acm'

    @reference.results = results
    @reference.total_found = total_found

    @reference.save!

  end

  def process_results_base(results)

    nodes = results.search("//document")
    entries = []

    @logger.debug "NODES: #{nodes.length.to_s}"

    nodes.each do |node|
      entry = process_node_xml(node)
      entries << entry
    end

    return entries
  end

  def process_node_xml(node)
    hash_entry = {}
    hash_entry[:node] = node
    hashed_node = Crack::XML.parse(node.to_s)
    hashed_result = hashed_node["document"]

    if hashed_result["authors"] != nil
      # Substitui o ";" por "e" nos autores
      authors = hashed_result["authors"].gsub(";", " e ")
    else
      authors = ""
    end

    # "thesaurusterms" refere-se as keywords no XML da IEEE e cada "term" é uma keyword diferente
    if hashed_result["thesaurusterms"] != nil
      keywordsT = hashed_result["thesaurusterms"]["term"]

      # Se possui mais que uma keyword retorna um array
      if keywordsT.class.to_s == "Array"
        keywordsIndex = keywordsT.join(",")
      else
        keywordsIndex = keywordsT.to_s
      end
    end

    # Check if that data is already saved in database
    unless Ieee.find_by_title(hashed_result["title"])
      @ieee = Ieee.new

      @ieee.title = hashed_result["title"]
      @ieee.abstract = hashed_result["abstract"]
      @ieee.author = authors
      @ieee.publisher = hashed_result["publisher"]
      @ieee.pubtype = hashed_result["pubtype"]
      @ieee.link = hashed_result["pdf"]
      @ieee.pubtitle = hashed_result["pubtitle"]

      @ieee.save!
    end

    # -------------- LOG -----------------------------------------------------------------------

    @logger.debug "Tipo publicação: #{hashed_result["pubtype"]}"
    @logger.debug "Título: #{hashed_result["title"]}"
    @logger.debug "Título publicação: #{hashed_result["pubtitle"]}"
    @logger.debug "Keywords: #{keywordsT}"
    @logger.debug "Abstract: #{hashed_result["abstract"]}"
    @logger.debug "Autores: #{authors}"
    @logger.debug "Link Publicação: #{hashed_result["pdf"]}"
    @logger.debug "Editora: #{hashed_result["publisher"]}"

    @logger.debug "----------------------------------------------------------------------------------"

    # -------------- LOG -----------------------------------------------------------------------

    entry = BibTeX::Entry.new({
                      :key => hashed_result["arnumber"],
                      :address => hashed_result[""],
                      :abstract => hashed_result["abstract"],
                      :annote => hashed_result[""],
                      :author => authors,
                      :booktitle => hashed_result["pubtitle"],
                      :chapter => hashed_result[""],
                      :crossref => hashed_result[""],
                      :doi => hashed_result["doi"],
                      :edition => hashed_result[""],
                      :editor => hashed_result[""],
                      :eprint => hashed_result[""],
                      :howpublished => hashed_result[""],
                      :institution => hashed_result["affiliations"],
                      :isbn => hashed_result["isbn"],
                      :issn => hashed_result["issn"],
                      :journal => hashed_result["pubtitle"],
                      :keywordsIndex => keywordsIndex,
                      :month => hashed_result[""],
                      :note => hashed_result[""],
                      :number => hashed_result["issue"],
                      :organization => hashed_result[""],
                      :pages => hashed_result["spage"].to_s + "--" + hashed_result["epage"].to_s,
                      :publisher => hashed_result["publisher"],
                      :school => hashed_result["affiliations"],
                      :series => hashed_result[""],
                      :title => hashed_result["title"],
                      :url => hashed_result["mdurl"],
                      :volume => hashed_result["volume"],
                      :year => hashed_result["py"],
                      :query => @query.to_s,
                      :source => @library
                  })

    return entry
  end

end
