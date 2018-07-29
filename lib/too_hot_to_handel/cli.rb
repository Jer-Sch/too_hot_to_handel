class TooHotToHandel::CLI

  def initialize
    line_width = 74
    puts ""
    puts ""
    puts' ______        ,             ______   ,                              _ '.blue
    puts'(_) |         /|   |        (_) |    /|   |                  |      | |'.blue
    puts'    | __   __  |___|  __ _|_    | __  |___|  __,   _  _    __|   _  | |'.blue
    puts'  _ |/  \_/  \_|   |\/  \_|   _ |/  \_|   |\/  |  / |/ |  /  |  |/  |/ '.blue
    puts' (_/ \__/ \__/ |   |/\__/ |_/(_/ \__/ |   |/\_/|_/  |  |_/\_/|_/|__/|__/'.blue
    puts ""
    puts ("Bringing the latest classical music news straight to your command line!".center(line_width))
    puts ""
    puts ("To begin, type 'menu'".center(line_width))
    puts ""
    puts ("To exit at any time, type 'exit'.".center(line_width))
    puts ""
  end

  def call
    user_input = gets.strip.downcase

    while user_input != "exit"

      user_input = gets.strip.downcase

      case user_input
      when "menu"
        list_articles
      when "yes"
        puts "Please enter the article number.".blue
        open_content_in_browser
      when "no"
        list_articles
      when "exit"
        puts "It has been a pleasure. Please come back soon!".blue
        puts ""
        puts ""
      else
        puts ""
        puts "I didn't understand that. Please try again.".blue
      end
    end
  end

  def prepare_articles
    TooHotToHandel::Scraper.scrape_classical_reviews if TooHotToHandel::ClassicalReview.all.count == 0

    line_width = 74
    puts ""
    puts ("Select the articles you would like to read by typing the corresponding number".blue.center(line_width))
    line_width = 89
    puts ("or the name of the article.".blue.center(line_width))
    puts ""
    line_width = 74
    puts ("-------------------------//-------------------------".center(line_width))
    puts ""
  end

  def list_articles
    prepare_articles

    reviews = TooHotToHandel::ClassicalReview.all

    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title.blue}"
      puts ""
      puts "    #{review.description}"
      puts ""
    end
    view_content
    user_prompts
  end

  def view_content
    user_input = gets.strip
    index = user_input.to_i-1 || "#{classical_review.name.downcase}"

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    TooHotToHandel::Scraper.scrape_review_content(classical_review) if !classical_review.content

    puts classical_review.content
  end

  def open_content_in_browser
    user_input = gets.strip
    index = user_input.to_i-1

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    Launchy.open("#{classical_review.url}")

    list_articles
  end

  def user_prompts
    line_width = 74
    puts ""
    puts ("Would you like to view this article in your web browser? Type 'yes' or 'no'.".blue.center(line_width))
    puts ""
    puts ("-------------------------//-------------------------".center(line_width))
    puts ""
  end
end
