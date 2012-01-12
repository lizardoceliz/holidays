class JavascriptsController < ApplicationController
  @states = State.find(:all)
end
