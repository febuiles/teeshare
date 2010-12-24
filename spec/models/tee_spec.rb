require 'spec_helper'

describe Tee do
  describe ".gather_data_from_url" do
    # don't mock this, useful to see if the "API" hasn't changed.
    it "obtains the shirt id, title and image from a URL and returns it as an array" do
      url = "http://www.threadless.com/product/2337/Mr_Cloud_s_New_Scarf/tab,guys/style,shirt"
      res = Tee.gather_data_from_url(url)

      res.first.should  == "2337"
      res.second.should == "Mr. Cloud's New Scarf"
      res.last.should   == "http://media.threadless.com//imgs/products/2337/636x460design_01.jpg"
    end
  end
end
