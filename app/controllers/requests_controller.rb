class RequestsController < ApplicationController
  before_action :authenticate_coordinator
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Requests", :requests_path

  # GET /requests
  # GET /requests.json
  def index
    @requests = current_user.requests.order('created_at DESC').page params[:page]
    add_breadcrumb "All", :requests_path
  end

  def drafts
    @requests = current_user.requests.order('created_at DESC').where(status: 'draft').page params[:page]
    add_breadcrumb "Drafts", :drafts_requests_path
    render 'index'
  end

  def submitted
    @requests = current_user.requests.order('created_at DESC').where(status: 'submitted').page params[:page]
    add_breadcrumb "Submitted", :submitted_requests_path
    render 'index'
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @access_requests = @request.access_requests
    add_breadcrumb "Request No. #{@request.id}"
  end

  # GET /requests/new
  def new
    @request = current_user.requests.build
    add_breadcrumb "New Request"
  end

  # GET /requests/1/edit
  def edit
    redirect_to @request, notice: "Request already submitted" if @request.submitted?
    add_breadcrumb "Request No. #{@request.id}", @request
    add_breadcrumb "Finalise"
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = current_user.requests.build(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to new_request_access_request_path(@request) }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        @request.update(status: "submitted")
        @request.access_requests.each { |access_request| access_request.submit(current_user) }
        format.html { redirect_to @request }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # No coordinator can access requests
    def authenticate_coordinator
      redirect_to root_path unless current_user.coordinator?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:end_user_id, :requester_id, :status, :note, access_requests_attributes: [:id, :_destroy, :request_id, :access_account_id, :permission_id])
    end
end
