require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do

  describe '#index' do
    it 'responds with a 200' do
      loan = Loan.create!(funded_amount: 100.0)
      get :index, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end

    it 'provides loan and payment data' do
      loan = Loan.create!(funded_amount: 1000.0)
      loan.payments.create!(amount: 100.0)
      get :index, loan_id: loan.id
      expect(JSON.parse(response.body)['loan']['funded_amount']).to eq('1000.0')
      expect(JSON.parse(response.body)['payments'].size).to eq(1)
      expect(JSON.parse(response.body)['payments'][0]['amount']).to eq('100.0')
    end
  end

  describe '#create' do
    it 'responds with a 200' do
      loan = Loan.create!(funded_amount: 100)
      post :create, loan_id: loan.id, payment: {amount: 50}
      expect(response).to have_http_status(:ok)
    end

    it 'returns successful payment data' do
      loan = Loan.create!(funded_amount: 100)
      post :create, loan_id: loan.id, payment: {amount: 50}
      expect(JSON.parse(response.body)['amount']).to eq('50.0')
    end

    context 'if the payment is greater than loan balance' do
      it 'responds with a 400 due to overpayment' do
        loan = Loan.create!(funded_amount: 100)
        post :create, loan_id: loan.id, payment: {amount: 200}
        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with errors due to overpayment' do
        loan = Loan.create!(funded_amount: 1000)
        post :create, loan_id: loan.id, payment: {amount: 1225}
        expect(JSON.parse(response.body)['amount']).to include('payment must be less than the balance of $1000.0')
      end
    end
  end

  describe '#show' do
  end
end
