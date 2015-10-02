helpers do
  def current_user
    @current_user = User.find_by(:id => session[:user_id]) if session[:user_id]
  end
end

before do
  pass if request.path_info == "/login"
  pass if request.path_info == "/signup"

  redirect '/login' unless current_user
end

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  email = params[:email]
  password = params[:password]

  user = User.find_by(:email => email)

  if user && user.authenticate(password)
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect '/login'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  username = params[:username]
  email = params[:email]
  password = params[:password]
  password_confirmation = params[:password_confirmation]

  user = User.find_by(:email => email)

  if user
    redirect '/signup'
  else
    user = User.create(
      :username => username,
      :email => email,
      :password => password)
      # :password_confirmation => password_confirmation)

    session[:user_id] = user.id
    redirect '/'
  end
end

get '/profile' do
  @user = User.find(session[:user_id])
  erb :profile
end

get '/profile/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get '/movies/new' do
  erb :new_movie
end

get '/movies' do
  @movies = Movie.where(:user_id => current_user.id)
  erb :movies
end

post '/movies' do
  title = params[:title]

  movie = Movie.find_by(:title => title)

  if movie
    redirect '/movies/new'
  else
    current_user.movies.create(:title => title)

    redirect '/movies'
  end
end
