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

get '/profile' do
  @rounds = Round.where(user_id: cur_user.id)

  erb :profile
end


get '/stats/:round_id' do
  @round = Round.find(params[:round_id])
  erb :stats_page
end

post '/user/new' do
  user = User.new(username: params[:username])
  user.password = params[:password]
  user.save!

  session[:user_id] = user.id
  redirect to('/')
end

post '/user/login' do
  user = User.find_by_username(params[:username])
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect to('/')
  else
    redirect to('/')
  end
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

  if answer.downcase == card.answer.downcase
    Guess.create({card_id: card.id, round_id: round_id, correct: 1})
    "Correct!"
  else
    Guess.create({card_id: card.id, round_id: round_id, correct: 0})
    "Incorrect!"
  end

end

get "/deck/next/:deck_id/:card_id" do
  deck = Deck.find(params[:deck_id])
  card = Card.find(params[:card_id])
  if Card.where(deck_id: deck.id).last.id > card.id
    redirect to("/deck/#{deck.id}/#{card.id.to_i + 1}")
  else
    #Change this to handle stats page
    correct = 0
    incorrect = 0
    Guess.where(round_id: session[:round]).each do |guess|
      if guess.correct == 1
        correct += 1
      else
        incorrect += 1
      end
    end
    round = Round.find(session[:round])
    Round.update(session[:round], correct: correct, incorrect: incorrect)
    redirect to("/stats/#{session[:round]}")
  end
end
