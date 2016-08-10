class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.datetime :payment_date
      t.integer :loan_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
