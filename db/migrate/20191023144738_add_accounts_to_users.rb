class AddAccountsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account_id, :integer, :default => nil
    add_column :users, :optout, :boolean, :default => false
    add_column :users, :stripe_customer_id, :string
    add_column :users, :stripe_token, :string
    add_column :users, :stripe_token_type, :string
    add_column :users, :subscription_type, :string, default: 'basic'
  end
end
