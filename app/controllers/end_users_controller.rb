class EndUsersController < ApplicationController
  before_action :set_end_user, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "End Users", :end_users_path
  # GET /end_users
  # GET /end_users.json
  def index
    @end_users = EndUser.all
  end

  # GET /end_users/1
  # GET /end_users/1.json
  def show
    @access_requests = @end_user.access_requests
    add_breadcrumb "#{@end_user.name}", @end_user
  end

  # GET /end_users/new
  def new
    @end_user = EndUser.new
    add_breadcrumb "New"
  end

  # GET /end_users/1/edit
  def edit
    add_breadcrumb "#{@end_user.name}", @end_user
    add_breadcrumb "Edit"
  end

  # POST /end_users
  # POST /end_users.json
  def create
    @end_user = EndUser.new(end_user_params)

    respond_to do |format|
      if @end_user.save
        format.html { redirect_to @end_user, notice: 'End user was successfully created.' }
        format.json { render :show, status: :created, location: @end_user }
      else
        format.html { render :new }
        format.json { render json: @end_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /end_users/1
  # PATCH/PUT /end_users/1.json
  def update
    respond_to do |format|
      if @end_user.update(end_user_params)
        format.html { redirect_to @end_user, notice: 'End user was successfully updated.' }
        format.json { render :show, status: :ok, location: @end_user }
      else
        format.html { render :edit }
        format.json { render json: @end_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /end_users/1
  # DELETE /end_users/1.json
  def destroy
    @end_user.destroy
    respond_to do |format|
      format.html { redirect_to end_users_url, notice: 'End user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_end_user
      @end_user = EndUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def end_user_params
      params.require(:end_user).permit(:first_name, :last_name, :email)
    end
end
