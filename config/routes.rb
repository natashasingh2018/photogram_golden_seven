Rails.application.routes.draw do

#CREATE
get("/photos/new", {:controller=>"photos", :action=>"new_form"})
get("/create_photo", {:controller=>"photos", :action=>"create_row"})

#READ
get("/photos/:the_id_number", {:controller=> "photos", :action=>"show"})
get("/photos", {:controller=> "photos", :action=>"index"})

#UPDATE
get("/photos/:the_id/edit", {:controller=> "photos", :action=>"edit_form"})
get("/update_photo/:the_id", {:controller=> "photos", :action=>"update_row"})

#DELETE
get("/photos/:the_id/delete", {:controller=> "photos", :action=>"delete_row"})

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
