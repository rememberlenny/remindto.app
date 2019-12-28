require 'digest/md5'

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

  def publication_size_list_for_select
    return [
      ['0 to 1000 readers a month', 'monthly_1000'],
      ['1000 to 5000 readers a month', 'monthly_5000'],
      ['5000 to 10,000 readers a month', 'monthly_10000'],
      ['10,000 to 25,000 readers a month', 'monthly_25000'],
      ['25,000 to 100,000 readers a month', 'monthly_100000'],
      ['More than 100,000 readers a month', 'monthly_more_100000'],
    ]
  end

  def gravatar(email)
    # get the email from URL-parameters or what have you and make lowercase
    email_address = email.downcase
    
    # create the md5 hash
    hash = Digest::MD5.hexdigest(email_address)
    
    # compile URL which can be used in <img src="RIGHT_HERE"...
    image_src = "https://www.gravatar.com/avatar/#{hash}"

    return image_src
  end

  def is_active_path(link_path, class_override)
    current_page?(link_path) ? class_override ? class_override : "active_path" : ""
  end
end
