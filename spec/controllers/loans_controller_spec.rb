require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns all of the loans' do
      Loan.create!(funded_amount: 1000.0)
      Loan.create!(funded_amount: 5000.0)
      Loan.create!(funded_amount: 10000.0)
      Loan.create!(funded_amount: 2000.0)
      Loan.create!(funded_amount: 4000.0)
      get :index
      expect(JSON.parse(response.body).size).to eq(5)
    end

    # it 'returns all loans including balance' do
    #   Loan.create!(funded_amount: 1000.0)
    #   Loan.create!(funded_amount: 5000.0)
    #   get :index
    #   #assertion
    # end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, id: loan.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end

    # it 'returns the balance due' do
    #   get :show, id: loan.id
    #   #assertion
    # end
  end
end
