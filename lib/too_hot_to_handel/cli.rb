class TooHotToHandel::CLI

  def call
    puts "Hello! This is Too Hot to Handel! Bringing classical music reviews right to your command line!"
    puts ""

    TooHotToHandel::Scraper.scrape_classical_reviews

    command
  end

  def command
    puts "If you please, select a review to read:"
    puts ""

    reviews = TooHotToHandel::ClassicalReview.all

    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title}"
    end
  end
end
