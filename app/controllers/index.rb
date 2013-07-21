get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    @decks = Deck.all
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

get "/deck/:deck_id/play" do
  @deck = Deck.find(params[:deck_id].to_i)
  @card = Card.where(deck_id: @deck.id).first

  round = Round.create({correct: 0, incorrect: 0, user_id: session[:user_id], deck_id: @deck.id})
  session[:round] = round.id

  erb :card_page
end

get "/deck/:deck_id/:card_id" do
  @deck = Deck.find(params[:deck_id].to_i)
  @card = Card.find(params[:card_id].to_i)

  erb :card_page
end

post "/deck/:deck_id/:card_id" do
  answer = params[:answer]
  round_id = session[:round]

  deck = Deck.find(params[:deck_id])
  card = Card.find(params[:card_id])

  if answer == card.answer
    Guess.create({card_id: card.id, round_id: round_id, correct: 1})
  else
    Guess.create({card_id: card.id, round_id: round_id, correct: 0})
  end

  if Card.where(deck_id: deck.id).last.id > card.id
    redirect to("/deck/#{deck.id}/#{card.id.to_i + 1}")
  else
    #Change this to handle stats page
    session[:round] = nil
    "Game Over"
  end
end
