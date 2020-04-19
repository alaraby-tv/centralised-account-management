class AccessRequestMailer < ApplicationMailer

  
  def submit(access_request)
    @access_request = access_request
    
    email = @access_request.approvable ? @access_request.approver.email : "support@alaraby.tv"
    mail to: email, subject: "Access Request Submitted"
  end
  
  def resubmit(access_request)
    @access_request = access_request
    
    email = @access_request.approvable ? @access_request.approver.email : "support@alaraby.tv"
    mail to: email, subject: "Access Request Resubmitted"
  end
  
  def approve(access_request)
    @access_request = access_request
    
    mail to: "support@alaraby.tv", subject: "Access Request Approved"
  end

  def reject(access_request)
    @access_request = access_request
    
    mail to: @access_request.access_requester_email, subject: "Access Request Rejected"
  end

  def cancel(access_request)
    @access_request = access_request

    mail to: "support@alaraby.tv", subject: "Access Request Cancelled"
  end

  def complete(access_request)
    @access_request = access_request
    
    mail to: @access_request.access_requester_email, subject: "Access Request Granted"
  end

  # Subject optionally can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #  e.g.: en.access_request_mailer.complete.subject
  #
end
