class Ieee < ActiveRecord::Base

  def search(query, protocol_id, max_returned, from, to)

    @search_url = 'http://ieeexplore.ieee.org/gateway/ipsSearch.jsp?querytext=' + query + '&hc=' + max_returned + '&pys=' + from + '&pye' + to
    @agent = Mechanize.new

    results = @agent.get(@search_url)

    root = results.search("//root")

    #fixme: Otimizar este código
    root.each do |node|
      hashed_node = Crack::XML.parse(node.to_s)
      @total_found = hashed_node["root"]["totalfound"]
    end

    process_results_base(results, protocol_id)

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id)

    results =  Ieee.where("protocol_id = ?", protocol_id).count

    @reference.protocol_id = protocol_id
    @reference.database_name = 'IEEE Xplore Digital Library'
    @reference.database = 'ieee'

    @reference.results = results
    @reference.total_found = @total_found.nil? ? 0 : @total_found

    @reference.save!
  end

  def process_results_base(results, protocol_id)

    nodes = results.search("//document")
    entries = []

    nodes.each do |node|
      entry = process_node_xml(node, protocol_id)
      entries << entry
    end

    return entries
  end

  def process_node_xml(node, protocol_id)
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

    @ieee = Ieee.new

    @ieee.title = hashed_result["title"]
    @ieee.abstract = hashed_result["abstract"]
    @ieee.author = authors
    @ieee.publisher = hashed_result["publisher"]
    @ieee.pubtype = hashed_result["pubtype"]
    @ieee.link = hashed_result["pdf"]
    @ieee.pubtitle = hashed_result["pubtitle"]
    @ieee.year = hashed_result["py"]
    @ieee.protocol_id = protocol_id

    @ieee.save!
  end

end
