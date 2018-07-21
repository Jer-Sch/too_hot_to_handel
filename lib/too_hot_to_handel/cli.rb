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
      puts "#{index} - #{review.title}. #{review.description}"
    end

    input = gets.strip
    index = input.to_i-1

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    TooHotToHandel::Scraper.scrape_review_content

  end
end
