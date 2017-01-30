class BuysController < ApplicationController
  def new
    @buy = Buy.new
  end

  def create
    @buy = Buy.new(params_buys)
    @buy.credit_card_id = params[:credit_card_id]
    debugger
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def params_buys
      params.require(:buy).permit(:description, :value)
    end
end