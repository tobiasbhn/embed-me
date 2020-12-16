class ApplicationController < ActionController::Base
  # not embeddable
  def private
    render plain: "private"
  end

  # is embeddable
  def embeddable
    text = embedded? ? "embeddable and indeed imbedded" : "embeddable but currently not embedded"
    render plain: text
  end
end
