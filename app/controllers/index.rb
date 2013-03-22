before do
@current_user = session[:user_id]
end


get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/signup' do
  @user = User.new(params)
  if @user.save
    login(@user)
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
  redirect '/'
end


get "/users/:user_name" do
  @user = User.find_by_name(params[:user_name])
  @has_access = true if @user.id == session[:user_id]
  erb :user_page
end


# upload = Upload.new
# upload.file = params[:image]
# upload.save
# redirect to ('/')