class Requests::AccessRequestsController < ApplicationController
  before_action :set_request
  before_action :set_access_request, only: [:show, :edit, :update, :destroy]

  # GET /requests/access_requests
  # GET /requests/access_requests.json
  def index
    @access_requests = @request.access_requests
  end

  # GET /requests/access_requests/1
  # GET /requests/access_requests/1.json
  def show
  end

  # GET /requests/access_requests/new
  def new
    @access_request = @request.access_requests.build
    @access_request.permissions.build
  end

  # GET /requests/access_requests/1/edit
  def edit
  end

  # POST /requests/access_requests
  # POST /requests/access_requests.json
  def create
    @access_request = @request.access_requests.build(access_request_params)

    respond_to do |format|
      if @access_request.save
        format.html { redirect_to new_request_access_request_path(@request), notice: 'Access Account was successfully added to your request.' }
        format.json { render :show, status: :created, location: @requests_access_request }
      else
        format.html { render :new }
        format.json { render json: @access_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/access_requests/1
  # PATCH/PUT /requests/access_requests/1.json
  def update
    respond_to do |format|
      if @access_request.update(access_request_params)
        @access_request.submit current_user
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
      @access_request = AccessRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_request_params
      params.fetch(:access_request).permit(:access_account_id, :end_user_id, permission_ids: [])
    end
end
