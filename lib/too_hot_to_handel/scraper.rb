class TooHotToHandel::Scraper

  BASE_URL = "https://www.gramophone.co.uk/classical-music-news/"

  def self.scrape_classical_reviews
    doc = Nokogiri::HTML(open(BASE_URL))

    doc.css(".flex.view-row-carton--flex").each do |review|
      title = review.css("h2").text
      blurb = review.css(".field-item.even").text
      url = "https://www.gramophone.co.uk" + review.css("h2 a").attr("href").text
      TooHotToHandel::ClassicalReview.new(title, blurb, url)
      # binding.pry
    end
  end

  def self.scrape_review_content(classical_review)
    url = classical_review.url
    doc = Nokogiri::HTML(open(url))
    # binding.pry
    classical_review.content = doc.css(".article-layout p").text.gsub!(/\A.*?(?=\))/, "(#{classical_review.title}")
#only shows text after first closing parenthesis. Unwanted text in <p> was being rendered.
  end
end


#review: doc.css(".flex.view-row-carton--flex")
#title: doc.css("h2").text
#description: doc.css(".field-item).text
#url: doc.css("h2 a").attr("href").value
#content: doc.css("p").text
