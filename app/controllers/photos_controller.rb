class PhotosController < ApplicationController


  def index
    @all_photos = Photo.all
    render("photos/index.html.erb")

  end

  def show
    #params hash looks like {"the_id_number"=>"1"}

    id_number = params["the_id_number"]
    p = Photo.find(id_number)
    @the_caption = p.caption
    @the_image_url = p.source
    @created_at_time = p.created_at
    render("show.html.erb")

  end


end
