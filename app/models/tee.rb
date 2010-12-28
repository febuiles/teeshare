require 'open-uri'

class Tee < ActiveRecord::Base
  include ThreadlessFeedParser

  validates_presence_of :shirt_id, :name, :image_url, :who, :link
  validates_format_of   :link, :with => URI::regexp(%w(http https))


  # Fetches the shirt id, shirt title and shirt image and returns
  # them as an array (in that order).
  def self.gather_data_from_url(url)
    doc = Nokogiri::HTML(open(url))

    # there are usually 5 ".title" in the doc, push our luck and pick first.
    title = doc.css("h1.title").first.content

    # take the first image, it's usually the design without a model
    image = image = doc.css(".product_view a").first["href"]

    # typical URL is http://www.threadless.com/product/2337/Mr_Cloud_s_New_Scarf/trash...
    id = url.split("/")[4]

    [id, title, image]
  end

  # Returns all the tees in the DB without the repetitions that appear when more
  # than one person buys the same shirt.
  def self.unique_tees
    Tee.all(:group => "shirt_id")
  end

  # returns a list of tees that no one has bought yet.
  def self.suggested_tees
    Tee.available_tees.shuffle.take(9)
  end

  # Returns the names of all the people who bought this shirt.
  # TODO: Add a new table (UsedBy) with `shirt_id`, and `who` so we don't
  # repeat the records on Tees. That allows us to remove Tee.unique_tees too.
  def bought_by
    Tee.where("shirt_id = #{self.shirt_id}").collect(&:who).uniq
  end
end
