class CreateReminderContainer < ActiveRecord::Migration[6.0]
  def change
    create_table :reminder_containers do |t|
      t.string :cta
      t.string :description
      t.string :color
      t.string :logo
      t.integer :user_id

      t.timestamps
    end
  end
end
