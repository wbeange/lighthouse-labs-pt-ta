helpers do
  def current_user
    @current_user = User.find_by(:id => session[:user_id]) if session[:user_id]
  end
end

before do
  pass if request.path_info == '/login' && request.request_method == 'GET'
  pass if request.path_info == '/login' && request.request_method == 'POST'
  pass if request.path_info == '/users/new' && request.request_method == 'GET'
  pass if request.path_info == '/users' && request.request_method == 'POST'

  redirect '/login' unless current_user
end

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  email = params[:email].downcase
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

get '/users/new' do
  erb :user_new
end

post '/users' do
  username = params[:username]
  email = params[:email].downcase
  password = params[:password]

  # halt 400, "Email can't be blank" if email.blank?
  # halt 409, "Email already exists" if User.exists?(:email => email)

  user = User.create(:username => username, :email => email, :password => password)

  halt 400, user.errors.full_messages.join(',') unless user.valid?

  redirect '/login'
end

get '/users/self' do
  @user = User.find(session[:user_id])
  erb :user
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :user
end

get '/movies/new' do
  erb :movie_new
end

get '/movies' do
  @movies = Movie.where(:user_id => current_user.id)
  erb :movies
end

post '/movies' do
  movie = current_user.movies.create(:title => params[:title])

  halt 400, movie.errors.full_messages.join(',') unless movie.valid?

  redirect '/movies'
end
