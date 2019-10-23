require 'sanitize'

class PagesController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def sample
    render :layout => false
  end

  def medium
    redirect_to root_path
  end

  def install
  end

  def success_later_update
  end

  def dnt
  end

  def faq
  end

  def optout
  end

  def optout_confirm
    @email = Sanitize.fragment(params[:email])
    @existed = false
    uu = User.where(email: @email)
    if uu.count > 0
      u = uu.first
      u.optout = true
      u.save
      @existed = true
    end
  end

  def about
  end

  def pricing
  end

  def howtouse
  end

  def homepage
    if user_signed_in?
      redirect_to user_home_path
    end
  end

  def help
  end

  def news
  end

  # Preview html email template
  def email
    tpl = (params[:layout] || 'welcome').to_sym
    tpl = :content unless [:email, :welcome, :content, :simple].include? tpl
    if params[:layout] == 'email'
      @later = Later.last
    end
    file = ('user_mailer/' + params[:layout] + '_email' || 'user_mailer/content_email')
    @user = (defined?(FactoryGirl) \
      ? User.new( FactoryGirl.attributes_for :user )
      : User.new( email: 'test@example.com', first_name: 'John', last_name: 'Smith' ))
    render file, layout: "emails/#{tpl}"
    if params[:premail] == 'true'
      puts "\n!!! USING PREMAILER !!!\n\n"
      pre = Premailer.new(response_body[0],  warn_level: Premailer::Warnings::SAFE, with_html_string: true)
      reset_response
      # pre.warnings
      render text: pre.to_inline_css, layout: false
    end
  end

  def error
    redirect_to root_path if flash.empty?
  end
end
