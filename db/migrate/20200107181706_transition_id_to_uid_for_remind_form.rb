class TransitionIdToUidForRemindForm < ActiveRecord::Migration[6.0]
  def change
    add_column :remind_forms, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false

    change_table :remind_forms do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE remind_forms ADD PRIMARY KEY (id);"
  end
end
