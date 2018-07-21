class TooHotToHandel::CLI

  def initialize
      puts "------------------------------------------------------"
      puts "This is Too Hot to Handel! Bringing classical music reviews right to your command line!"

  def call
    user_input = ""

    while user_input != "exit"
      puts ""
      puts "To view the latest classical music reviews, type 'show me'"
      puts ""
      puts "To quit at any time, type 'exit'."
      puts ""
      puts "Are you ready?"
      puts ""

      user_input = gets.strip.downcase

      case user_input
      when "show me"
        list_reviews
      when "web"
        Launchy.open("https://www.nytimes.com/spotlight/classical-music-reviews")
      else
        puts ""
        puts "I didn't understand that. Please try again."
      end
    end
  end

  def list_reviews
    TooHotToHandel::Scraper.scrape_classical_reviews

    puts ""
    puts "Select a review you would like to read:"
    puts ""

    reviews = TooHotToHandel::ClassicalReview.all

    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title}"
      puts ""
      puts "#{review.description}"
      puts ""
    end
    view_content
    TooHotToHandel::ClassicalReview.destroy_all
  end

  def view_content
    input = gets.strip
    index = input.to_i-1

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    TooHotToHandel::Scraper.scrape_review_content(classical_review)

    puts classical_review.content
    puts "------------------------------------------------------"
    end
  end
end
