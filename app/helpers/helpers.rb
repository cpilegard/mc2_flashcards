helpers do 
  def score(right, wrong)
    ((right / (right+wrong).to_f) * 100).to_i
  end
end