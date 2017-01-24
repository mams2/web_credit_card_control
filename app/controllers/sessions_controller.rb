class SessionsController < ApplicationController
  def new
    if log_in?
      redirect_to current_account
    end
  end

  def create
    account = Account.find_by(login: params[:session][:login])
    if account && account.authenticate(params[:session][:password])
      log_in(account)
      redirect_to account
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end