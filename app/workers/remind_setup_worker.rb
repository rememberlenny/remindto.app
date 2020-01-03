class RemindSetupWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { minutely(1) }

  def perform(account_id, email, url, delay_param)
    logger.info 'Running RemindSetupWorker ' + Time.now.utc.to_s
    Later.check_for_ready_laters
    logger.info 'Finished RemindSetupWorker ' + Time.now.utc.to_s
  end
end
