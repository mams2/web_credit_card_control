class BuysController < ApplicationController
  def new
    @buy = Buy.new
  end

  def create
    if log_in?
      list_of_buyers = {}
      params[:list_of_buyers].each{|buyer| list_of_buyers[buyer[:name]] = buyer[:value].to_f}
      @buy = Buy.new(params_buys)
      @buy.list_of_buyers = list_of_buyers
      @buy.credit_card_id = params[:credit_card_id]
      if @buy.save
        redirect_to CreditCard.find_by(id: params[:credit_card_id])
      else
        render 'new'
      end
    else
      redirect_to login_path
    end    
  end

  def edit
    @buy = Buy.find_by(id: params[:id])
    redirect_to current_account if @buy.nil?
  end

  def update

  end

  def destroy

  end

  private
    def params_buys
      params.require(:buy).permit(:purchase_date, :description, :value, :current_payment,
                                  :total_payment)
    end
end