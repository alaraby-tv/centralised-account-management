class AccessRequestsController < ApplicationController
  before_action :set_access_request, only: [:show]# , :edit, :update, :destroy]

  # GET /access_requests
  # GET /access_requests.json
  def index
    @access_requests = AccessRequest.all.page params[:page]
  end

  # GET /access_requests/1
  # GET /access_requests/1.json
  def show
  end

  # GET /access_requests/new
  # def new
  #   @access_request = AccessRequest.new
  # end

  # GET /access_requests/1/edit
  # def edit
  # end

  # POST /access_requests
  # POST /access_requests.json
  # def create
  #   @access_request = AccessRequest.new(access_request_params)

  #   respond_to do |format|
  #     if @access_request.save
  #       format.html { redirect_to @access_request, notice: 'Access Request was successfully created.' }
  #       format.json { render :show, status: :created, location: @access_request }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @access_request.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /access_requests/1
  # PATCH/PUT /access_requests/1.json
  # def update
  #   respond_to do |format|
  #     if @access_request.update(access_request_params)
  #       format.html { redirect_to @access_request, notice: 'Access Request was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @access_request }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @access_request.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /access_requests/1
  # DELETE /access_requests/1.json
  # def destroy
  #   @access_request.destroy
  #   respond_to do |format|
  #     format.html { redirect_to access_requests_url, notice: 'Access Request was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_access_request
    @access_request = AccessRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def access_request_params
    params.require(:access_request).permit(:name, :access_request_id, :note, permission_ids: [])
  end
end
