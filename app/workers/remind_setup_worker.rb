class RemindSetupWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { minutely(1) }

  def perform(account_id, remind_user_id, url, delay_date)
    logger.info 'Running RemindSetupWorker ' + Time.now.utc.to_s
    Later.create(account_id: account_id, user_id: remind_user_id, url: url, destined_at: delay_date)
    logger.info 'Finished RemindSetupWorker ' + Time.now.utc.to_s
  end
end


# t.integer "user_id"
# t.string "url"
# t.datetime "destined_at"
# t.string "title"
# t.text "description"
# t.string "image_url"
# t.datetime "content_updated"
# t.boolean "has_sent"
# t.integer "account_id"
# t.datetime "created_at", precision: 6, null: false
# t.datetime "updated_at", precision: 6, null: false