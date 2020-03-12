class Requests::BuildController < ApplicationController

  include Wicked::Wizard

  steps :accounts, :permissions, :confirmation

  def show
    @request = Request.find(params[:request_id])
    @request.access_requests.build
    render_wizard
  end

  def update
    @request = Request.find(params[:request_id])
    @request.update(request_params)
    render_wizard @request
  end

  private

  def request_params
      params.require(:request).permit(:status, access_requests_attributes: [:id, :_destroy, :note, :request_id, :access_account_id, permission_ids: []])
    end
end
