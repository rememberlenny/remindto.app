class AddAccountIdToRemindForms < ActiveRecord::Migration[6.0]
  def change
    add_column(:remind_forms, :account_id, :integer)
  end
end
