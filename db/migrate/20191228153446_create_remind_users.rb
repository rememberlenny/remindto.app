class CreateRemindUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :remind_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
