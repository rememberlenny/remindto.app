class AddAccountIdToEmailTemplate < ActiveRecord::Migration[6.0]
  def change
    add_column :email_templates, :accounts_id, :integer
  end
end
