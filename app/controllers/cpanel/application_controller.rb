class Cpanel::ApplicationController < ApplicationController
  layout "cpanel"
  #before_filter :require_user, :require_admin

  def require_admin
      render_404 unless Setting.admin_emails.include?(current_user.email)
  end
end
