helpers do 
  def score(right, wrong)
  	return 0 if right == 0 && wrong == 0
    ((right / (right+wrong).to_f) * 100).to_i
  end

  def cur_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end
end