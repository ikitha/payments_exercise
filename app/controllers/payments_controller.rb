class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: {loan: Loan.find(params[:loan_id]).as_json(methods: :balance_due), payments: Loan.find(params[:loan_id]).payments}
  end

  def create
    loan = Loan.find(params[:loan_id])
    payment = loan.payments.build(payment_params)
    if payment.save
      render json: payment
    else
      render json: payment.errors, status: :bad_request
    end
  end

  def show
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :payment_date)
  end
end
