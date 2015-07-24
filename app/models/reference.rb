class Reference < ActiveRecord::Base

  def search_ieee

    @search_url = 'http://ieeexplore.ieee.org/gateway/ipsSearch.jsp?querytext=(' + self.query + ')'
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
    @ieee.generic_string = self.query

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

    return entry
  end

end
