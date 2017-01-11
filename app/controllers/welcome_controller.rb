class WelcomeController < ApplicationController
  def index
    puts "is premium? #{ current_user.is_premium }, #{ current_user.sub_id }"
  end

  def about
  end
end
