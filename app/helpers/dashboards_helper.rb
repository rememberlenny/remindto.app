module DashboardsHelper
  def is_domain_blank_class
    if !@current_account.domain.blank?
      return 'completed'
    end
  end

  def is_user_script_up_class
    if !@current_account.has_script_setup != true
      return 'completed'
    end
  end

end
