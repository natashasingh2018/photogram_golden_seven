require "rails_helper"

# feature "Home page" do
#   it "is the photos index page", points: 0, hint:  "Should always pass since starting point takes care of this" do
#     visit "/"
#
#     expect(page).to have_css("h1", text: "List of Photos")
#   end
# end

feature "Photo details page" do
  it "has a functional RCAV", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page)
  end
end

feature "Photo details page" do
  it "has a p tag for the caption", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page).to have_css("p")
  end
end

feature "Photo details page" do
  it "has an img tag for the image", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page).to have_css("img")
  end
end

feature "Photo details page" do
  it "displays the correct caption", points: 3 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page).to have_content(photo.caption)
  end
end

feature "Photo details page" do
  it "displays the correct image", points: 3 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page).to have_css("img[src*='#{photo.source}']")
  end
end

feature "Index page" do
  it "has a functional RCAV", points: 1 do
    visit "/photos"

    expect(page)
  end
end

feature "Index page" do
  it "displays multiple photos", points: 1 do
    create_list(:photo, 2)

    visit "/photos"

    expect(page).to have_css("img", minimum: 2)
  end
end

feature "Index page" do
  it "display multiple links to details pages", points: 1 do
    create_list(:photo, 2)

    visit "/photos"

    expect(page).to have_css("a[href*='/photos/']", minimum: 2)
  end
end

feature "Index page" do
  it "display every existing photo", points: 5 do
    photos = create_list(:photo, 5)

    visit "/photos"

    photos.each do |photo|
      expect(page).to have_css("img[src*='#{photo.source}']")
    end
  end
end

feature "Index page" do
  it "displays a link to the details page for every existing photo", points: 5 do
    photos = create_list(:photo, 5)

    visit "/photos"

    photos.each do |photo|
      expect(page).to have_css("img[src*='#{photo.source}']")
    end
  end
end

feature "New photo page" do
  it "has a functional RCAV", points: 1 do
    visit "/photos/new"

    expect(page)
  end

  it "has a form", points: 1 do
    visit "/photos/new"

    expect(page).to have_css("form", count: 1)
  end

  it "has a label for 'Caption'", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/photos/new"

    expect(page).to have_css("label", text: "Caption")
  end

  it "has a label for 'Image URL'", points: 1, hint: h("copy_must_match label_for_input") do
    visit "/photos/new"

    expect(page).to have_css("label", text: "Image URL")
  end

  it "has two inputs", points: 1, hint: h("label_for_input") do
    visit "/photos/new"

    expect(page).to have_css("input", count: 2)
  end

  it "has a button to 'Create Photo'", points: 1, hint: h("copy_must_match") do
    visit "/photos/new"

    expect(page).to have_css("button", text: "Create Photo")
  end

  it "creates a photo when submitted", points: 3 do
    initial_number_of_photos = Photo.count

    visit "/photos/new"
    click_on "Create Photo"

    final_number_of_photos = Photo.count
    expect(final_number_of_photos).to eq(initial_number_of_photos + 1)
  end

  it "saves the caption when submitted", points: 2, hint: "Be sure your label is 'Caption' and is tied to the correct input through its `for=\"\"` attribute" do
    test_caption = "Photogram test caption, added at time #{Time.now}."

    visit "/photos/new"
    fill_in("Caption", with: test_caption)
    click_on "Create Photo"

    last_photo = Photo.order(created_at: :asc).last
    expect(last_photo.caption).to eq(test_caption)
  end

  it "saves the image URL when submitted", points: 2, hint: "Be sure your label is 'Image URL' and is tied to the correct input through its `for=\"\"` attribute" do
    test_source = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Pluto-01_Stern_03_Pluto_Color_TXT.jpg/240px-Pluto-01_Stern_03_Pluto_Color_TXT.jpg"

    visit "/photos/new"
    fill_in("Image URL", with: test_source)
    click_on "Create Photo"

    last_photo = Photo.order(created_at: :asc).last
    expect(last_photo.source).to eq(test_source)
  end
end

feature "Delete photo" do
  it "removes a row from the table", points: 5 do
    photo = create(:photo)

    visit "/delete_photo/#{photo.id}"

    expect(Photo.exists?(photo.id)).to be false
  end

  it "redirects user to the index page", points: 3 do
    photo = create(:photo)

    visit "/delete_photo/#{photo.id}"

    expect(page).to have_current_path("/photos") # should not depend on path
  end
end

feature "Edit photo page" do
  it "has a functional RCAV", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page)
  end

  it "has a form", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_css("form", count: 1)
  end

  it "has two inputs", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_css("input", count: 2)
  end

  it "has a label for 'Caption'", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_css("label", text: "Caption")
  end

  it "has a label for 'Image URL'", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_css("label", text: "Image URL")
  end

  it "has a button to 'Update Photo'", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_css("button", text: "Update Photo")
  end

  it "has caption prepopulated", points: 3 do
    photo = create(:photo, caption: "Old caption")

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_css("input[value='Old caption']")
  end

  it "has image source prepopulated", points: 3 do
    photo = create(:photo, source: "http://old.image/source.jpg")

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_css("input[value='http://old.image/source.jpg']")
  end

  it "updates caption when submitted", points: 5, hint: "Be sure your label is 'Caption' and is tied to the correct input through its `for=\"\"` attribute" do
    photo = create(:photo, caption: "Old caption")
    test_caption = "New caption, added at #{Time.now}"

    visit "/photos/#{photo.id}/edit"
    fill_in("Caption", with: test_caption)
    click_on "Update Photo"

    photo_as_revised = Photo.find(photo.id)

    expect(photo_as_revised.caption).to eq(test_caption)
  end

  it "updates image source when submitted", points: 5, hint: "Be sure your label is 'Image URL' and is tied to the correct input through its `for=\"\"` attribute" do
    photo = create(:photo, source: "http://old.image/source.jpg")
    test_source = "http://new.image/source_#{Time.now.to_i}.jpg"

    visit "/photos/#{photo.id}/edit"
    fill_in("Image URL", with: test_source)
    click_on "Update Photo"

    photo_as_revised = Photo.find(photo.id)

    expect(photo_as_revised.source).to eq(test_source)
  end

  it "redirects user to the show page", points: 3 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"
    click_on "Update Photo"

    expect(page).to have_current_path("/photos/#{photo.id}") # should not depend on path
  end
end
