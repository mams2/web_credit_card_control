class StaticPagesController < ApplicationController
  def home
    redirect_to current_account if log_in?
  end

  def about
  end
end