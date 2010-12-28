require 'spec_helper'

describe ThreadlessFeedParser do
  before :all do
    class Feed; include ThreadlessFeedParser; end
  end

  shared_examples_for "shirt methods" do
    it "returns shirts with an id, image, title and url" do
      @tee.shirt_id.should_not be_nil
      @tee.name.should_not be_empty
      @tee.link.should_not be_empty
      @tee.image_url.should_not be_empty
    end

    it "cleans the urls, removing GA data" do
      @tee.link.should == "http://www.threadless.com/product/2633/Psusennes_MMXII"
    end

    it "removes the author line (by ...) from the shirt name" do
      @tee.name.should == "Psusennes MMXII"
    end

    it "raises an exception if the feed passed is not a string" do
      expect { Feed.new_tees([]) }.to raise_error(Exception)
    end
  end

  describe ".new_tees" do
    before :all do
      @tees = Feed.new_tees(sample_atom_feed)
      @tee = @tees.first
    end
    it "returns a list of shirts from the feed" do
      @tees.length.should == 6
      @tees.collect(&:shirt_id).should == [2633, 2616, 2615, 2614, 2613, 2612]
    end

    it_should_behave_like "shirt methods"
  end

  describe ".available_tees" do
    before :all do
      create_tee(:shirt_id => 2612)
      @tees = Feed.available_tees(sample_atom_feed)
      @tee = @tees.first
    end
    it "returns a list of shirts that're not in the DB" do
      @tees.length.should == 5
      @tees.collect(&:shirt_id).should_not include(2612)
    end

    it_should_behave_like "shirt methods"
  end
end
