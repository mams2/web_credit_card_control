class UsersController < ApplicationController

  def index
    @users = User.where(account_id: current_account.id) if log_in?
    redirect_to login_path if @users.nil?
  end

  def new
    redirect_to login_path unless log_in?
    @user = User.new
  end

  def create
    @user = User.new(params_users)
    if log_in?
      @user.account_id = current_account.id
      if @user.save
        redirect_to current_account
      else
        render 'new'
      end
    else
      redirect_to login_path
    end
  end

  def edit
    if log_in?
      @user = User.find_by(id: params[:id])
      redirect_to current_account if @user.nil? || (current_account.id != @user.account_id && !current_account.admin)
    else
      redirect_to login_path
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(params_users)
      redirect_to current_account
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      redirect_to current_account
    else
      redirect_to current_account
    end
  end

  private
    def params_users
      params.require(:user).permit(:name)
    end

end