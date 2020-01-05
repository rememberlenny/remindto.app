class CreateRemindForms < ActiveRecord::Migration[6.0]
  def change
    create_table :remind_forms do |t|
      t.string :title
      t.text :form_blocks
      t.string :cta

      t.timestamps
    end
  end
end
