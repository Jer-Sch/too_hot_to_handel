class TooHotToHandel::Scraper

  BASE_URL = "https://www.nytimes.com/spotlight/classical-music-reviews"

  def self.scrape_classical_reviews
    doc = Nokogiri::HTML(open(BASE_URL))


    doc.css(".css-1cp3ece").each do |classical_review|
      binding.pry
    end
  end


end


#review: doc.css(".css-1cp3ece")
#title: doc.css(".css-p4c7a9").text
#date: doc.css(".css-y9ybov")
#description: doc.css(".css-1up1n27").text
#url: doc.css(".css-1xc9qte a").attr("href")
