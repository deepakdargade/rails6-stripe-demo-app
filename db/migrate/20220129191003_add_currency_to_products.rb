class AddCurrencyToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :currency, :string, default: 'inr'
  end
end
