before do
@current_user = User.find(session[:user_id])
end


get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/signup' do
  @user = User.new(params)
  if @user.save
    login(@user)
    @user.albums << Album.create(:name => "Your first album!")
    redirect "/users/#{@user.name}"
  else
    erb :index
  end
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    login(@user)
    redirect "/users/#{@user.name}"
  else
    erb :index
  end
end

post '/upload' do
  photo = Photo.new
  photo.image_path = params[:image]
  photo.save!
  album = Album.find(params[:album_id])
  album.photos << photo
  redirect "/albums/#{album.id}"
end


get "/users/:user_name" do
  @user = User.find_by_name(params[:user_name])
  @albums = @user.albums
  @has_access = true if @user.id == session[:user_id]
  erb :user_page
end

post '/album/new' do
  @current_user.albums << Album.create(:name => params[:album_name])
  redirect "/users/#{@current_user.name}"
end

get '/albums/:album_id' do
  @album = Album.find(params[:album_id])
  @albums = @current_user.albums
  @has_access = true if @current_user.albums.include?(@album)
  erb :album
end


# upload = Upload.new
# upload.file = params[:image]
# upload.save
# redirect to ('/')