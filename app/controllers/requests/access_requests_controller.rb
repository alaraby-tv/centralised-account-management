class Requests::AccessRequestsController < ApplicationController
  before_action :set_request
  before_action :set_access_request, only: [:show, :edit, :update, :destroy, :approve, :reject, :cancel, :complete]

  add_breadcrumb "Requests", :requests_path

  # GET /requests/access_requests
  # GET /requests/access_requests.json
  def index
    @access_requests = @request.access_requests
    add_breadcrumb "Request No. #{@request.id}", @request
  end

  # GET /requests/access_requests/1
  # GET /requests/access_requests/1.json
  def show
    add_breadcrumb "Request No. #{@request.id}", @request
    add_breadcrumb "Access Request No. #{@access_request.id}", [@request, @access_request]
  end

  # GET /requests/access_requests/new
  def new
    @access_request = @request.access_requests.build
    @access_request.permissions.build
    add_breadcrumb "Request No. #{@request.id}", @request
    add_breadcrumb "New Access Request"
  end

  # GET /requests/access_requests/1/edit
  def edit
    add_breadcrumb "Request No. #{@request.id}", @request
    add_breadcrumb "Access Request No. #{@access_request.id}", [@request, @access_request]
    add_breadcrumb "Edit"
  end

  # POST /requests/access_requests
  # POST /requests/access_requests.json
  def create
    @access_request = @request.access_requests.build(access_request_params)
    @access_request.access_requester = current_user
    respond_to do |format|
      if @access_request.save
        format.html { redirect_to new_request_access_request_path(@request), notice: 'Access Account was successfully added to your request.' }
        format.json { render :show, status: :created, location: @requests_access_request }
      else
        @access_request.permissions.clear
        format.html { render :new }
        format.json { render json: @access_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    @access_request.approve current_user, params[:comment]
    redirect_back fallback_location: root_path, notice: "Access Approved"
  end

  def reject
    if params[:comment] == ""
      redirect_back fallback_location: root_path, flash: { error: "Please provide a comment" }
    else
      @access_request.reject current_user, params[:comment]
      redirect_back fallback_location: root_path, notice: "Access Rejected" 
    end
  end

  def cancel
    if params[:comment] == ""
      redirect_back fallback_location: root_path, flash: { error: "Please provide a comment" }
    else
      @access_request.cancel current_user, params[:comment]
      redirect_back fallback_location: root_path, notice: "Access Cancelled"
    end
  end

  def complete
    @access_request.complete current_user
    redirect_back fallback_location: root_path, notice: "Access Granted"
  end

  # PATCH/PUT /requests/access_requests/1
  # PATCH/PUT /requests/access_requests/1.json
  def update
    respond_to do |format|
      if @access_request.update(access_request_params)
        @access_request.resubmit current_user
        format.html { redirect_to @request, notice: 'Access request was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_request }
      else
        format.html { render :edit }
        format.json { render json: @access_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/access_requests/1
  # DELETE /requests/access_requests/1.json
  def destroy
    @access_request.destroy
    respond_to do |format|
      format.html { redirect_to @request, notice: 'Access request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:request_id])
    end

    def set_access_request
      @access_request = @request.access_requests.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_request_params
      params.fetch(:access_request).permit(:access_account_id, :end_user_id, :note, permission_ids: [])
    end
end
