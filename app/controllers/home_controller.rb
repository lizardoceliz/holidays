class HomeController < ApplicationController
  def index
    if user_signed_in?
      render "hola"
    end
  end
end
