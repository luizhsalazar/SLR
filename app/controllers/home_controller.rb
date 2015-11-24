class HomeController < ApplicationController

  def terms_of_service

  end

  def privacy_policy

  end

  def community_rules

  end

  def user_manual
    send_file(
        "#{Rails.root}/public/user-guide.pdf",
        filename: "manual-usuario.pdf",
        type: "application/pdf"
    )
  end

end
