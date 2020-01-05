module DashboardsHelper
  def is_domain_blank_class
    if !@account.domain.blank?
      return 'completed'
    end
  end

  def is_user_script_up_class
    if !@account.has_script_setup != true
      return 'completed'
    end
  end

  def remind_count_for_user(remind_user_id)
    Later.where(account_id: @account.id, user_id: remind_user_id).count
  end
end
