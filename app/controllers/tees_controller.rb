class TeesController < ApplicationController
  def index
    @tees = Tee.unique_tees
  end

  def new
  end

  def create
    id, name, image_url = Tee.gather_data_from_url(params[:link])
    who = params[:who]

    tee = Tee.new(:shirt_id => id, :name => name,
                  :image_url => image_url, :who => who)

    if tee.valid? && tee.save!
      redirect_to tees_path
    else
      raise Exception, "Invalid t-shirt data: #{params[:link]}"
    end
  end
end
