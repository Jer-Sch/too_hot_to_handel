class TooHotToHandel::ClassicalReview
  attr_accessor :title, :blurb, :url, :content

  @@all = []

  def initialize(title, blurb, url)
    @title = title
    @blurb = blurb
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end
end
