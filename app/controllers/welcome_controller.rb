class WelcomeController < ApplicationController

  before_filter :session_timeout

  def index
  end

end
