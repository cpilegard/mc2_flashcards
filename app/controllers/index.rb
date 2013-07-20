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
  redirect to('/round/card/1')
end

get '/round/card/:card_id' do
  if session[:card_id]
      card = Card.find(params[:card_id].to_i - 1)
      if card.answer == session[:guess]
        @correct = true
        session[:correct] = session[:correct].to_i + 1
      else
        @correct = false
        @answer = card.answer
      end
      @number_correct = session[:correct].to_i
      @number_incorrect = card.id - @number_correct
    end

  if params[:card_id].to_i > Card.last.id
    @gameover = true
    @number_correct = session[:correct].to_i
    @number_incorrect = Card.find(params[:card_id].to_i - 1).id - @number_correct
    session.clear
  else
    @card = Card.find(params[:card_id].to_i)
  end

  erb :card_page
end

post '/round/card/:card_id' do
  session[:card_id] = params[:card_id].to_i
  session[:guess] = params[:guess]
  redirect to("/round/card/#{session[:card_id].to_i + 1}")
end
