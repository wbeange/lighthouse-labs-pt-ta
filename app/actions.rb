# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  if User.exists?(:email => params[:email], :password => params[:password])
    "/profile?email=#{params[:email]}"
  else
    redirect '/login'
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  if !User.exists?(:email => params[:email])
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    redirect "/profile/#{user.id}" if user
  end

  redirect '/signup'
end

get '/profile/:id' do
  @user = User.find(params[:id])
  erb :profile
end
