class Ieee < ActiveRecord::Base

  def search_ieee(query)

    # @logger = Logger.new("SLR.log")
    #
    # @logger.debug "query:  #{query}"

    @search_url = 'http://ieeexplore.ieee.org/gateway/ipsSearch.jsp?querytext=' + query
    @agent = Mechanize.new

    results = @agent.get(@search_url)

    @logger = Logger.new("SLR.log")

    @logger.debug "Query URL:  #{@search_url}"

    entries = process_results_base(results)

    @logger.debug "Referências totais processadas: #{entries.size.to_s}"

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

    @ieee = Ieee.new

    @ieee.title = hashed_result["title"]
    @ieee.abstract = hashed_result["abstract"]
    @ieee.author = authors
    @ieee.publisher = hashed_result["publisher"]
    @ieee.pubtype = hashed_result["pubtype"]
    @ieee.link = hashed_result["pdf"]
    @ieee.pubtitle = hashed_result["pubtitle"]

    @ieee.save!

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
