class HomeController < ApplicationController
  def index
    if user_signed_in?
      render :index
    end
  end
end
