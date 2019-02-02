class TooHotToHandel::Scraper

  BASE_URL = "https://www.nytimes.com/spotlight/classical-music-reviews"

  def self.scrape_classical_reviews
    doc = Nokogiri::HTML(open(BASE_URL))

    doc.css(".css-1cp3ece").each do |review|
      title = review.css(".css-1dq8tca").text
      description = review.css(".css-1echdzn").text
      url = "https://www.nytimes.com" + review.css("a").attr("href")
      TooHotToHandel::ClassicalReview.new(title, url, description)
    end
  end

  def self.scrape_review_content(classical_review)
    url = classical_review.url
    doc = Nokogiri::HTML(open(url))

    classical_review.content = doc.css(".StoryBodyCompanionColumn").text
    classical_review.content.force_encoding("UTF-8")
  end
end


#review: doc.css(".css-1cp3ece")
#title: doc.css(".css-1dq8tca e1xfvim30").text
#description: doc.css(".css-1up1n27").text
#url: doc.css(".css-1xc9qte a").attr("href")
#content: doc.css(".StoryBodyCompanionColumn").text
