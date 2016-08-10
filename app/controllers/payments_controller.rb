class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: {loan: Loan.find(params[:loan_id]).as_json(methods: :balance_due), payments: Loan.find(params[:loan_id]).payments}
  end

  def create
  end

  def show
  end
end
