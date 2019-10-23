class LaterSchedulerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(1) }

  def perform
    Later.check_for_ready_laters
    logger.info 'Running LaterScheduler ' + Time.now.utc.to_s
  end
end
