require 'spec_helper'

describe TeesController do
  describe "#create" do

    it "creates a new entry with valid information" do
      url = "http://www.threadless.com/product/2337/Mr_Cloud_s_New_Scarf/tab,guys/style,shirt"
      expected = ["2337", "Mr. Cloud's New Scarf",
                  "http://media.threadless.com/imgs/products/2337/636x460design_01.jpg"]
      Tee.should_receive(:gather_data_from_url).with(url).and_return(expected)

      expect {
        post :create, { :link => url, :who => "me" }
      }.to change(Tee, :count).by(1)
    end

    it "redirects to tees_path after creating a new object" do
      url = "http://www.threadless.com/product/2337/Mr_Cloud_s_New_Scarf/tab,guys/style,shirt"
      expected = ["2337", "Mr. Cloud's New Scarf",
                  "http://media.threadless.com/imgs/products/2337/636x460design_01.jpg"]
      Tee.stub!(:gather_data_from_url).and_return(expected)

      post :create, { :link => url, :who => "me" }
      response.should be_redirect
    end

    it "raises an exception when the link is invalid" do
      url = "testing link"
      Tee.stub!(:gather_data_from_url).and_return([])
      expect {
        post :create, { :link => url, :who => "me" }
      }.to raise_error(Exception, "Invalid t-shirt data: #{url}")
    end
  end
end
