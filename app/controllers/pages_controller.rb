class PagesController < ApplicationController
  def home
    @updates = Update.all
  end
end
