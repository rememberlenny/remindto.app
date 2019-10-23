class CreateLaters < ActiveRecord::Migration[6.0]
  def change
    create_table :laters do |t|
      t.integer :user_id
      t.string :url
      t.timestamp :destined_at
      t.string :title
      t.text :description
      t.string :image_url
      t.timestamp :content_updated
      t.boolean :has_sent, :default => false
      t.integer :account_id

      t.timestamps
    end
  end
end
