class TooHotToHandel::CLI

  def initialize
    line_width = 110
    puts ("------------------------------------------------------".center(line_width))
    puts ""
    puts "#######                  #     #                 #######           #     #                              ".blue
    puts "   #     ####   ####     #     #  ####  #####       #     ####     #     #   ##   #    # #####  ###### #".blue
    puts "   #    #    # #    #    #     # #    #   #         #    #    #    #     #  #  #  ##   # #    # #      #".blue
    puts "   #    #    # #    #    ####### #    #   #         #    #    #    ####### #    # # #  # #    # #####  #".blue
    puts "   #    #    # #    #    #     # #    #   #         #    #    #    #     # ###### #  # # #    # #      #".blue
    puts "   #    #    # #    #    #     # #    #   #         #    #    #    #     # #    # #   ## #    # #      #".blue
    puts "   #     ####   ####     #     #  ####    #         #     ####     #     # #    # #    # #####  ###### ######".blue
    puts ""
    puts ("Bringing classical music reviews right to your command line!".center(line_width))
  end

  def call
    user_input = ""

    while user_input != "exit"
      line_width = 110
      puts ""
      puts ("To view the latest classical music reviews, type 'show me'".center(line_width))
      puts ("then type the number of the review you would like to read.".center(line_width))
      puts ""
      puts ("To enable browser mode and view the reviews in your web browser, type 'show me on the web'".center(line_width))
      puts ("then type the number of the review you would like to open.".center(line_width))
      puts ""
      puts ("To quit at any time, type 'exit'.".center(line_width))
      puts ""
      puts ("Are you ready?".center(line_width))
      puts ""

      user_input = gets.strip.downcase

      case user_input
      when "show me"
        list_reviews
      when "show me on the web"
        list_reviews_in_browser
      when "exit"
        line_width = 110
        puts ("It has been a pleasure. Please come back soon!".center(line_width))
      else
        line_width = 110
        puts ""
        puts ("I didn't understand that. Please try again.".center(line_width))
      end
    end
  end

  def list_reviews
    TooHotToHandel::Scraper.scrape_classical_reviews

    line_width = 110
    puts ""
    puts ("Select a review you would like to read:".center(line_width))
    puts ""

    reviews = TooHotToHandel::ClassicalReview.all

    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title.blue}"
      puts ""
      puts "#{review.description}"
      puts ""
    end
    view_content
    TooHotToHandel::ClassicalReview.destroy_all
  end

  def list_reviews_in_browser
    TooHotToHandel::Scraper.scrape_classical_reviews

    line_width = 110
    puts ""
    puts ("Select a review you would like to read:".center(line_width))
    puts ""

    reviews = TooHotToHandel::ClassicalReview.all

    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title.red}"
      puts ""
      puts "#{review.description}"
      puts ""
    end
    view_content_in_browser
    TooHotToHandel::ClassicalReview.destroy_all
  end

  def view_content
    input = gets.strip
    index = input.to_i-1

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    TooHotToHandel::Scraper.scrape_review_content(classical_review)

    puts classical_review.content
    line_width = 110
    puts ("------------------------------------------------------".center(line_width))
  end

  def view_content_in_browser

    input = gets.strip
    index = input.to_i-1

    classical_review = TooHotToHandel::ClassicalReview.all[index]
    TooHotToHandel::Scraper.scrape_review_content(classical_review)
    Launchy.open("#{classical_review.url}")
  end
end
