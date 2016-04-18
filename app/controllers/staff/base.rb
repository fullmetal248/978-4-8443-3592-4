class Staff::Base < ApplicationController
  private
  def current_staff_member
    if session[:staff_member_id]
      @current_session_member ||=
          StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member
end