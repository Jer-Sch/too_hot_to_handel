class TooHotToHandel::CLI

  def initialize
    line_width = 110
    puts ""
    puts ""
    puts ("#######                  #     #                 #######           #     #                              ".yellow.center(line_width))
    puts ("   #     ####   ####     #     #  ####  #####       #     ####     #     #   ##   #    # #####  ###### #".yellow.center(line_width))
    puts ("   #    #    # #    #    #     # #    #   #         #    #    #    #     #  #  #  ##   # #    # #      #".yellow.center(line_width))
    puts ("   #    #    # #    #    ####### #    #   #         #    #    #    ####### #    # # #  # #    # #####  #".yellow.center(line_width))
    puts ("   #    #    # #    #    #     # #    #   #         #    #    #    #     # ###### #  # # #    # #      #".yellow.center(line_width))
    puts ("   #    #    # #    #    #     # #    #   #         #    #    #    #     # #    # #   ## #    # #      #".yellow.center(line_width))
    puts ("   #     ####   ####     #     #  ####    #         #     ####     #     # #    # #    # #####  ###### ######".yellow.center(line_width))
    puts ""
    puts ("Bringing the latest classical music news right to your command line!".center(line_width))
    puts ""
    puts ("To begin, type 'menu'".center(line_width))
    puts ""
    puts ("To exit at any time, type 'exit'.".center(line_width))
    puts ""
  end

  def call
    user_input = ""
    line_width = 110

    while user_input != "exit"

      user_input = gets.strip.downcase

      case user_input
      when "menu"
        main_menu
      when "yes"
        puts ("Please re-enter the article number.".red.center(line_width))
        open_content_in_browser
      when "no"
        main_menu
      when "exit"
        break
        # puts ("It has been a pleasure. Please come back soon!".red.center(line_width))
      else
        puts ""
        puts ("I didn't understand that. Please try again.".red.center(line_width))
      end
    end
  end

  def prepare_articles
    TooHotToHandel::Scraper.scrape_classical_reviews if TooHotToHandel::ClassicalReview.all.count == 0

    line_width = 110
    puts ""
    puts ("Select the review you would like to read by typing the corresponding number, 1 to 10:".red.center(line_width))
    puts ""
    puts ("-------------------------//-------------------------".yellow.center(line_width))
    puts ""
  end

  def list_articles
    prepare_articles

    reviews = TooHotToHandel::ClassicalReview.all
    line_width = 110
    reviews.each.with_index(1) do |review, index|
      puts "#{index} - #{review.title.yellow}"
      puts ""
      puts "    #{review.description}"
      puts ""
    end
    view_content
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

    main_menu
  end

  def user_prompts
    line_width = 110
    puts ""
    puts ("Would you like to view this article in your web browser? Type 'yes' or 'no'.".red.center(line_width))
    puts ""
    puts ("-------------------------//-------------------------".red.center(line_width))
    puts ""
  end

  def main_menu
    list_articles
    user_prompts
  end
end
