module Mixpanelable
  extend ActiveSupport::Concern

  included do
    before_filter :set_mp_cookie_information
  end

  def set_mp_cookie_information
    # In your case, the cookies will be namespaced differently
    # so remember to use your own namespace.
    if (mp_cookies = cookies['mp_mixcel'])
      @mp_properties = JSON.parse(mp_cookies)
    end
  end
end