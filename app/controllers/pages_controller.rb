class PagesController < ApplicationController
  def home
    @updates = Update.all.order(:created_at).reverse_each
  end
end
