class TooHotToHandel::ClassicalReview
  attr_accessor :title, :url, :content, :description

  @@all = []

  def initialize(title, url, description)
    @title = title
    @url = url
    @description = description
    @@all << self
  end

  def self.all
    @@all
  end
end
