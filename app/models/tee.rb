require 'open-uri'

class Tee < ActiveRecord::Base

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
end
