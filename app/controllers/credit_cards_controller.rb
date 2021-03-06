class CreditCardsController < ApplicationController

  def new
    redirect_to login_path unless log_in?
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(credit_cards_params)
    if log_in?
      @credit_card.account_id = current_account.id
      if @credit_card.save
        redirect_to @credit_card
      else
        render 'new'
      end
    else
      redirect_to login_path
    end
  end

  def index
    @credit_cards = current_account.credit_cards if log_in?
    redirect_to login_path if @credit_cards.nil?
  end

  def show
    if log_in?
      @credit_card = CreditCard.find_by(id: params[:id])
      @total = 0
      @buyers={}
      redirect_to current_account if @credit_card.nil? || 
                                    (current_account.id != @credit_card.account_id && !current_account.admin)
    else
      redirect_to login_path
    end
  end

  def edit
    if log_in?
      @credit_card =CreditCard.find_by(id: params[:id])
      redirect_to current_account if @credit_card.nil? ||
                                    (current_account.id != @credit_card.account_id && !current_account.admin)
    else
      redirect_to login_path
    end
  end

  def update
    @credit_card =CreditCard.find_by(id: params[:id])
    if @credit_card.update_attributes(credit_cards_params)
      redirect_to @credit_card
    else
      render 'edit'
    end
  end

  def destroy
    @credit_card = CreditCard.find_by(id: params[:id])
    if @credit_card.destroy
      redirect_to current_account
    else
      render 'show'
    end
  end

  private
    def credit_cards_params
      params.require(:credit_card).permit(:name, :last_four_digits, :payment_day)
    end

end