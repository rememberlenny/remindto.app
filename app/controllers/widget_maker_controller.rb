class WidgetMakerController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def new
    @reminder = ReminderContainer.new
  end

  def create
    @reminder = ReminderContainer.new(reminder_params)
    @reminder.save
    render json: @reminder
  end

  def check_email
    redirect_to root_path, :flash => { :success => "We sent you a magic link! Check your inbox." }
  end

  def new_user_by_email_only
    params[:new_user][:password] = Faker::DizzleIpsum.words(4).join('!').first(20)
    @user = User.new(user_params)
    render json: { status: "success", description: "User created." }
  end

  private

    def reminder_params
      params.require(:reminder).permit(:cta, :description, :color)
    end

    def user_params
      params.require(:new_user).permit(:email)
    end
end
