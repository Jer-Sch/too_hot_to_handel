class TooHotToHandel::ClassicalReview
  attr_accessor :title, :url, :description

  @@all = []

  def initialize(title, url)
    @title = title
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end
end
