class TeesController < ApplicationController
  def index
    @tees = Tee.unique_tees
    @available_tees = Tee.suggested_tees
  end

  def new
    @available_tees = Tee.suggested_tees
  end

  def create
    id, name, image_url = Tee.gather_data_from_url(params[:link])
    who = format_username(params[:who])

    tee = Tee.new(:shirt_id => id, :name => name,
                  :image_url => image_url, :who => who,
                  :link => params[:link])

    if tee.valid? && tee.save!
      redirect_to tees_path
    else
      raise Exception, "Invalid t-shirt data: #{params[:link]}"
    end
  end

  protected
  # add a @ to the `who` field if it's missing
  def format_username(text)
    text[0,1] == "@" ? text : "@#{text}"
  end
end
