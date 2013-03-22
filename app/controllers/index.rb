before do
@current_user = params[:user_id]
end


get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/signup' do
  User.create(params)
  redirect '/'
end


post '/upload' do
  photo = Photo.new
  photo.image_path = params[:image]
  photo.save!
  redirect '/'
end


# upload = Upload.new
# upload.file = params[:image]
# upload.save
# redirect to ('/')