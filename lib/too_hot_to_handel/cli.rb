class TooHotToHandel::CLI

  def call
    puts "Hello! This is Too Hot to Handel! Bringing classical music reviews right to your command line!"
    puts ""

    TooHotToHandel::Scraper.scrape_classical_reviews

  end
end
