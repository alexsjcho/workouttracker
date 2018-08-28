class HomeController < ApplicationController
  def index
    @users = User.all
  end
end

class HomeController < ApplicationController
  def show
  end
end
