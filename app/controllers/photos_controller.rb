class PhotosController < ApplicationController

  def new_form
    render("photos/new_form.html.erb")
  end

  def create_row
    the_image_url = params["the_image_url"]
    the_caption = params["the_caption"]
    p = Photo.new
    p.source = the_image_url
    p.caption = the_caption
    p.save
    # render("photos/create_row.html.erb")
    redirect_to("/photos")
  end


  def edit_form
    @the_photo = Photo.find(params[:the_id])
    render("photos/edit_form.html.erb")

  end
  def update_row
    p = Photo.find(params[:the_id])
    the_image_url = params["the_source"]
    the_caption = params["the_caption"]
    p.source = the_image_url
    p.caption = the_caption
    p.save
    redirect_to("/photos")

  end
  def index
    @all_photos = Photo.all.order({:created_at => :desc})
    render("photos/index.html.erb")

  end

  def show
    #params hash looks like {"the_id_number"=>"1"}

    id_number = params["the_id_number"]
    @myphoto = Photo.find(id_number)
    render("show.html.erb")

  end

  def delete_row
    p = Photo.find(params[:the_id])
    p.destroy
    redirect_to("/photos")
  end

end
