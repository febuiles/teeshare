require 'uri'
require 'open-uri'
require 'ostruct'
module ThreadlessFeedParser
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # returns an array of shirts with all the new shirts on the Threadless
    # Atom Feed. If no feed is specified it will use the default feed URL:
    # http://feeds.feedburner.com/ThreadlessWeekly
    def new_tees(feed=nil)
      feed_text = fetch_text_from_feed(feed)
      links = links_from_atom_feed(feed_text)
      titles = titles_from_atom_feed(feed_text)
      ids = extract_ids_from_links(links)
      imgs = shirt_images_for(ids)

      shirts = []

      ids.each_with_index do |id, i|
        url = URI.parse(links[i])

        shirt = OpenStruct.new
        shirt.shirt_id = id

        # remove the 'by ...' from the shirt title
        shirt.name = titles[i].split(" by")[0]
        # discard Google Analytics data
        shirt.link = "http://#{url.host}#{url.path}"

        shirt.image_url = imgs[i]
        shirts << shirt
      end
      shirts
    end

    # returns an array of all the new shirts on the Threadless Atom Feed that
    # no one has bought yet. If no feed is specified it will use the default feed URL:
    # http://feeds.feedburner.com/ThreadlessWeekly
    def available_tees(feed=nil)
      shirts_in_db = Tee.select(:shirt_id).collect(&:shirt_id).uniq
      new_shirts = new_tees(feed)
      new_shirts_ids = new_shirts.collect(&:shirt_id)

      available_shirts = new_shirts_ids - shirts_in_db
      new_shirts.reject { |shirt| !available_shirts.include?(shirt.shirt_id) }
    end

    protected
    # fetches the Threadless ATOM feed and returns the relevant text.
    def fetch_text_from_feed(feed)
      feed ||= open("http://feeds.feedburner.com/ThreadlessWeekly")
      doc = Nokogiri::XML(feed)
      text = doc.css("item description").text
      Nokogiri::HTML(text)
    end

    # extracts the shirt links of a Threadless feed.
    def links_from_atom_feed(feed)
      links = feed.css("a").collect { |a| a["href"] }
      links.grep(/threadless\.com/)
    end

    # extracts the shirt titles of a Threadless feed.
    def titles_from_atom_feed(feed)
      feed.css("a h2").collect(&:text)
    end

    # extracts the shirt ids from a list of shirt links.
    def extract_ids_from_links(links=[])
      links.collect { |link| link.split("/")[4].to_i }
    end

    # builds the URLs for the shirt images based on a given list of
    # shirt ids.
    def shirt_images_for(ids=[])
      ids.collect { |id| build_shirt_image_url(id) }
    end

    # returns the image URL for a shirt given its id.
    def build_shirt_image_url(id)
      "http://media.threadless.com/imgs/products/#{id}/636x460design_01.jpg"
    end
  end
end
