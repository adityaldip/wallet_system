module Api
    class TransactionsController < ApplicationController
      before_action :authenticate_request!
  
      def create
        transaction = Transaction.new(transaction_params)
        if transaction.save
          render json: transaction, status: :created
        else
          render json: transaction.errors, status: :unprocessable_entity
        end
      end
  
      def user_transactions
        user_wallet_id = @current_user.wallet.id
        transactions = Transaction.where(source_wallet_id: user_wallet_id).or(Transaction.where(target_wallet_id: user_wallet_id))
  
        if transactions.any?
          render json: transactions, status: :ok
        else
          render json: { message: 'No transactions found for this user' }, status: :not_found
        end
      end
  
      private
  
      def transaction_params
        params.require(:transaction).permit(:source_wallet_id, :target_wallet_id, :amount, :transaction_type)
      end
    end
  end
  