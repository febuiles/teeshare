class TeesController < ApplicationController
  def index
  end

  def new
  end

  def create
    id, shirt_name, shirt_image_url = Tee.gather_data_from_url(params[:link])
    who = params[:who]

    tee = Tee.create(:shirt_id => id, :shirt_name => shirt_name,
                     :shirt_image_url => shirt_image_url, :who => who)

    if tee.save
      redirect_to tees_path
    else
      raise Exception, "Invalid t-shirt data: #{params[:link]}"
    end
  end
end
