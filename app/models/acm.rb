class Acm < ActiveRecord::Base

  def search(query, protocol_id, max_results, from, to)

    max = max_results.to_f / 20

    j = 1

    # querytext flag does a search in FULL TEXT and METADATA fields
    # md flags does a search in METADATA fields only
    # within + adv get the exact same results as in a correct research in acm website
    doc = Nokogiri::HTML(open("http://dl.acm.org/results.cfm?within=" + query + "&adv=1")) # + "&since_year=" + from.to_s + "&before_year=" + to.to_s))

    doc_total = doc.css("table.small-text td")

    # Search for last characters and remove comma to get the total found value
    total_found = doc_total.first.child.to_s[18..-1].gsub(/,/, '').to_f

    @logger = Logger.new("SLR.log")

    not_found = total_found > max_results.to_f + 20000

    # If not found any result acm shows all references in index page after search
    unless not_found
      index = 0
      i = 0

      while i < max

        search_query = "http://dl.acm.org/results.cfm?within=" + query + "&start=" + j.to_s + "&adv=1"

        doc = Nokogiri::HTML(open(search_query))

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

          index += 1
        }

        index = 0
        i += 1

        # Result comes with 20 references per page
        j += 20

        break if total_found <= j
      end
    end

    results =  Acm.where("protocol_id = ?", protocol_id).count

    @reference = Reference.find_or_initialize_by(protocol_id: protocol_id, database_name: 'ACM Digital Library')

    @reference.protocol_id = protocol_id
    @reference.database_name = 'ACM Digital Library'
    @reference.database = 'acm'

    @reference.results = results

    @reference.total_found = not_found ? 0 : total_found

    @reference.save!

  end

end
