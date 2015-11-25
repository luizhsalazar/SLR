class Acm < ActiveRecord::Base

  def search(query, protocol_id, max_results, from, to)

    max = max_results.to_f / 20

    j = 0

    doc = Nokogiri::HTML(open("http://dl.acm.org/results.cfm?query=" + query + "&since_year=" + from + "&before_year=" + to))

    total = doc.css("#resfound").first.text

    index = total.index('r')

    total_found = total[0..index-2].gsub(/,/, '').to_f

    not_found = total_found > max_results.to_f + 20000

    # If not found any result acm shows all references in index page after search
    unless not_found
      index = 0
      i = 0

      while i < max

        search_query = "http://dl.acm.org/results.cfm?query=" + query + "&start=" + j.to_s + "&since_year=" + from + "&before_year=" + to

        doc = Nokogiri::HTML(open(search_query))

        results = doc.css("#results").css("div.details")

        titles = results.css("div.title")
        authors = results.css("div.authors")
        pubtitles = results.css("div.source")
        abstracts = doc.css("div.abstract")

        titles.each { |title|

          link = title.css("a")
          pubtitle = pubtitles[index]

          @acm = Acm.new
          @acm.title = title.text
          @acm.link = 'http://dl.acm.org/' + link[0]['href']

          @acm.abstract = ActionView::Base.full_sanitizer.sanitize(abstracts[index].to_s).strip.gsub(/&#13;/, '')
          @acm.author = ActionView::Base.full_sanitizer.sanitize(authors[index].to_s).strip.gsub(/&#13;/, '')

          @acm.pubtitle =pubtitle.text
          @acm.year = pubtitle.css("span.publicationDate").text

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
