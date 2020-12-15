class ApplicationController < ActionController::Base
  # not embeddable
  def private
    render plain: "private"
  end

  # is embeddable
  def embeddable
    render plain: "embeddable"
  end
end
