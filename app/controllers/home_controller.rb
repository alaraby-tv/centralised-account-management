class HomeController < ApplicationController
  def index
    if current_user.approver?
      @access_requests = AccessRequest.submitted_requests.joins(:access_account).where(access_accounts: {approver: current_user})
    else
      @access_requests = AccessRequest.approved_requests.to_a
      submitted_requests = AccessRequest.submitted_requests.joins(:access_account).where(access_accounts: {approver: nil})
      submitted_requests.each { |access_request| @access_requests << access_request }
    end
  end
end
