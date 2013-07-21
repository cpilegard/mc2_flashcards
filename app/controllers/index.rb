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

get '/stats/' do
  @round = Round.find(session[:round_id])
  erb :stats_page
end

post '/user/new' do
  username = params[:username]
  password = params[:password]
  user = User.create({username: username, password: password})
  session[:user_id] = user.id
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
  if session[:user_id]
    redirect to('/round/card/1')
  else
    redirect to('/user/login')
  end
end

get '/round/card/:card_id' do
  if session[:card_id]
      card = Card.find(params[:card_id].to_i - 1)
      if card.answer.downcase == session[:guess].down
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
    # redirect to("/stats/#{}")
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
