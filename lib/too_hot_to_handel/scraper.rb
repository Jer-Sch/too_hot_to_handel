class TooHotToHandel::Scraper

  BASE_URL = "https://www.nytimes.com/spotlight/classical-music-reviews"

  def self.scrape_classical_reviews
    doc = Nokogiri::HTML(open(BASE_URL))

    doc.css(".css-1cp3ece").each do |classical_review|
      title = doc.css(".css-p4c7a9").text
      description = doc.css(".css-1up1n27").text
      url = "https://www.nytimes.com" + doc.css(".css-1xc9qte a").attr("href")
      TooHotToHandel::ClassicalReview.new(title, url)
    end
  end

  def self.scrape_review_content(classical_review)
    url = classical_review.url
    doc = Nokogiri::HTML(open(url))


end


#review: doc.css(".css-1cp3ece")
#title: doc.css(".css-p4c7a9").text
#description: doc.css(".css-1up1n27").text
#url: doc.css(".css-1xc9qte a").attr("href")
