class TransactionsController < ApplicationController
  def create
    @transaction = Transaction.new(transaction_params)
    
    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:source_wallet_id, :target_wallet_id, :amount, :transaction_type)
  end
end
