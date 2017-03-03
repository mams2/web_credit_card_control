class AccountsController < ApplicationController
  def index
    if log_in?
      if current_account.admin
        @accounts = Account.all
      else
        redirect_to current_account
      end
    else
      redirect_to login_path
    end
  end

  def show
    if log_in?
      @account = Account.find_by(id: params[:id])
      if @account.nil?
        redirect_to accounts_path
      elsif current_account != @account && !current_account.admin
        redirect_to current_account
      end
    else
      redirect_to login_path
    end 
  end

  def new
    if log_in?
      redirect_to current_account unless current_account.admin
      @account = Account.new
    else
      redirect_to login_path
    end  
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to @account
    else
      render 'new'
    end
  end

  def edit
    if log_in?
      @account = Account.find_by(id: params[:id])
      redirect_to accounts_path if @account.nil? || (current_account != @account && !current_account.admin)
    end
  end

  def update
    @account = Account.find_by(id: params[:id])
    if @account.update_attributes(account_params)
      redirect_to @account
    else
      render 'edit'
    end
  end

  def destroy
    @account = Account.find_by(id: params[:id])
    if @account.destroy
      redirect_to account_path
    else
      render 'show'
    end
  end

  private
    def account_params
      params.require(:account).permit(:login, :name, :password, 
                                      :password_confirmation, :admin)
    end

end