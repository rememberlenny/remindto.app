class ServiceController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def oembed
    url = params[:url]
    host = env["HTTP_HOST"]
    response = {}
    if url.split(host + "/f/").count == 0
    else
      uuid = url.split(host + "/f/")[1]
      if uuid.split("?").count != 1
        uuid = uuid[0]
      end
      accounts = Account.where(uid: uuid)
      if accounts.count == 0
        redirect_to root_path, alert: "The account you are looking for does not exist. Please check the reminder URL."
      end
      account = accounts.first
      if account.nil? || !account.owner_id
        redirect_to root_path, alert: "The account you are looking for does not exist. Please check the reminder URL."
      end
      user = User.find(account.owner_id)
      email = user.email
      title = account.company_name
      author_url = account.domain
      response[:version] = "1.0"
      response[:provider_name] = "RemindToRead"
      response[:provider_url] = "https:\/\/readturn.com"
      response[:author_name] = email
      response[:author_url] = author_url
      response[:title] = title
      response[:html] = "<iframe scrolling=\"no\" width=\"800\" height=\"350\" style=\"border:none!important;width:100%!important;height:350px;\" src=\"https:\/\/readturn.com\/f\/" + uuid + "?as_embed=true\"><\/iframe>"
      response[:height] = 480
      response[:width] = 800
      response[:type] = "rich"
      response[:thumbnail_url] = "https:\/\/readturn.com\/form.png"
      response[:thumbnail_width] = 1200
      response[:thumbnail_height] = 630
    end
    render json: response
  end
end
