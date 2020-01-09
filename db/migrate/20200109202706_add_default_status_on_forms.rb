class AddDefaultStatusOnForms < ActiveRecord::Migration[6.0]
  def change
    add_column(:remind_forms, :can_be_changed, :boolean, default: true)
  end
end
