helpers do
  def current_user
    @current_user = User.find_by(:id => session[:user_id]) if session[:user_id]
  end
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

  if user && user.password == password
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

  user = User.find_by(:email => email)

  if user
    redirect '/signup'
  else
    user = User.create(:username => username, :email => email, :password => password)
    session[:user_id] = user.id
    redirect '/'
  end
end

get '/profile/:id' do
  if params[:id]
    user_id = params[:id]
  else
    user_id = session[:user_id]
  end

  @user = User.find(user_id)
  erb :profile
end
