class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find_by(id: params[:id])
    redirect_to accounts_path if @account.nil?
  end

  def new
    @account = Account.new
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
    @account = Account.find_by(id: params[:id])
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