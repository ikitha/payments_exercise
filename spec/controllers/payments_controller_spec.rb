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
  end

  describe '#show' do
  end
end
