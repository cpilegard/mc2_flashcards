get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
  erb :index
end

get '/user/signup' do
  erb :signup
end

get '/user/login' do
  erb :login
end

post '/user/new' do
  username = params[:username]
  password = params[:password]
  User.create({username: username, password: password})
  redirect to('/')
end

post '/user/login' do
  username = params[:username]
  password = params[:password]
  user = User.where(username: username).first
  if user.password == password
    session[:user_id] = user.id
  else
    "Incorrect login"
  end
  redirect to('/')
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/round/new' do

end