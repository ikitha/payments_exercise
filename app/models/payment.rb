class Payment < ActiveRecord::Base
  belongs_to :loan

  validate :check_loan_balance

  private

  def check_loan_balance
    balance = loan.balance_due
    if balance - amount < 0
      errors.add(:amount, "payment must be less than the balance of $#{balance}")
    end
  end
end
