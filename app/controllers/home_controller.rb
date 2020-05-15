class HomeController < ApplicationController
  def index
    if current_user.approver?
      @access_requests = AccessRequest.requests('submitted', 'resubmitted').includes(:access_account).where(access_accounts: {approver: current_user}).page params[:page]
    else
      @access_requests = AccessRequest.requests('approved').page(params[:page])
      @access_requests_with_no_approval = AccessRequest.requests('submitted', 'resubmitted').joins(:access_account).where(access_accounts: {approver: nil}).page params[:page]
    end
  end
end
