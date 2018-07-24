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
    puts ""
    puts ("To begin, type 'menu'".center(line_width))
    puts ""
    puts ("To view the latest classical music reviews, type 'show me'".center(line_width))
    puts ("then type the number of the review you would like to read.".center(line_width))
    puts ""
    puts ("To exit, type 'exit'.".center(line_width))
    puts ""
  end

  def call

    user_input = ""

    while user_input != "exit"

      user_input = gets.strip.downcase

      case user_input
      when "menu"
        list_reviews_for_browser
      when "1".."10"
        list_reviews_for_browser
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

    prepare_reviews

    reviews = TooHotToHandel::ClassicalReview.all

    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title.blue}"
      puts ""
      puts "    #{review.description}"
      puts ""
    end
    view_content
  end

  def list_reviews_for_browser

    list_reviews

    user_prompts

    view_content_in_browser

  end

  def view_content

    user_input = gets.strip
    index = user_input.to_i-1

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    TooHotToHandel::Scraper.scrape_review_content(classical_review) if !classical_review.content

    puts classical_review.content

    line_width = 110
    puts ("------------------------------------------------------".center(line_width))
  end

  def view_content_in_browser
    line_width = 110
    puts ""
    puts ("To view this article in your browser, re-enter the article number.".center(line_width))

    user_input = gets.strip
    index = user_input.to_i-1

    classical_review = TooHotToHandel::ClassicalReview.all[index]

    Launchy.open("#{classical_review.url}")
  end

  def prepare_reviews

    TooHotToHandel::Scraper.scrape_classical_reviews if TooHotToHandel::ClassicalReview.all.count == 0

    line_width = 110
    puts ""
    puts ("Select the review you would like to read by typing the corresponding number, 1 to 10:".red.center(line_width))
    puts ""
  end

  def user_prompts
    line_width = 110
    puts ("To return to the list, type 'main menu'.".center(line_width))
    puts ""
    puts ("To exit at any time, type 'exit'.".center(line_width))
  end
end
