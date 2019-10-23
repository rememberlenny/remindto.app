module ApplicationHelper
  include CommonHelper

  # Render a partial only one time.
  #
  # Useful for rendering partials that require JavaScript like Google Maps
  # where other views may have also included the partial.
  def render_once(view, *args, &block)
    @_render_once ||= {}
    if @_render_once[view]
      nil
    else
      @_render_once[view] = true
      render(view, *args, &block)
    end
  end

  def current_account
    if !@current_user.nil? && !@current_user.account_id.nil?
      current_account = Account.find(@current_user.account_id)
      return current_account
    end
  end

  def account_embed_url id
    account = Account.find(id)
    uid = account.uid
    return reminder_form_page_url(uid)
  end

  def current_accounts
    if !@current_user.nil? && !@current_user.account_id.nil?
      current_accounts = Account.where(owner_id: @current_user.id)
      index = current_accounts.find_index current_account
      passed_accounts = []
      i = 0
      current_accounts.each do |account|
        if index != i
          passed_accounts << account
        end
        i = i + 1
      end
      return passed_accounts
    end
  end

  def all_accounts
    current_accounts = Account.where(owner_id: @current_user.id)
    return current_accounts
  end

  def asset_url asset
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end

  def shorten_url_text(url, max_length, delimiter = '')
    stop_strings = ['http://', '.html']
    stop_strings.each do |stop_string|
      url = url.gsub(stop_string, '')
    end
    rurl = url.reverse.slice(0, max_length/2).reverse
    url = url.slice(0, max_length/2)
    return url + delimiter + rurl
  end
end
