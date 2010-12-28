require 'spec_helper'

describe Tee do
  describe ".gather_data_from_url" do
    # don't mock this, useful to see if the "API" hasn't changed.
    it "obtains the shirt id, title and image from a URL and returns it as an array" do
      url = "http://www.threadless.com/product/2337/Mr_Cloud_s_New_Scarf/tab,guys/style,shirt"
      res = Tee.gather_data_from_url(url)

      res.first.should  == "2337"
      res.second.should == "Mr. Cloud's New Scarf"
      res.last.should   == "http://media.threadless.com/imgs/products/2337/636x460design_01.jpg"
    end

    it "works on spanish URLs" do
      url = "http://es.threadless.com/product/2013/I_Wish_Procrastination_Was_a_Marketable_Skill"
      res = Tee.gather_data_from_url(url)

      res.first.should  == "2013"
      res.second.should == "I Wish Procrastination Was a Marketable Skill"
      res.last.should   == "http://media.threadless.com/imgs/products/2013/636x460design_01.jpg"
    end
  end

  describe "#bought_by" do
    it "returns a list of the people that bought a shirt" do
      create_tee
      create_tee(:who => "@diegoeche")
      create_tee

      t = Tee.where("shirt_id = 1337").first
      t.bought_by.should == ["@febuiles", "@diegoeche"]
    end
  end

  describe ".unique_tees" do
    it "returns a list without repetitions" do
      create_tee
      create_tee(:who => "@diegoeche")

      Tee.where("shirt_id = 1337").length.should > 1
      tees = Tee.unique_tees
      tees.length.should == 1
      tees.first.image_url.should == "fake"
      tees.first.name.should == "Test shirt"
      tees.first.shirt_id.should == 1337
    end
  end
end
