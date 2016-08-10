class Loan < ActiveRecord::Base
  has_many :payments

  def balance_due
    self.funded_amount - self.payments.sum(:amount)
  end
end
