class AccessAccountsController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_access_account, only: [:show, :edit, :update, :destroy]

  # GET /access_accounts
  # GET /access_accounts.json
  def index
    @access_accounts = AccessAccount.order(:name).page params[:page]
    add_breadcrumb "Access Accounts", :access_accounts_path
  end

  # GET /access_accounts/1
  # GET /access_accounts/1.json
  def show
    @access_requests = @access_account.access_requests.page params[:page]
    add_breadcrumb "#{@access_account.name}", :access_account_path
  end

  # GET /access_accounts/new
  def new
    @access_account = AccessAccount.new
    @access_account.permissions.build
    add_breadcrumb "New Access Accounts"
  end

  # GET /access_accounts/1/edit
  def edit
  end

  # POST /access_accounts
  # POST /access_accounts.json
  def create
    @access_account = AccessAccount.new(access_account_params)

    respond_to do |format|
      if @access_account.save
        format.html { redirect_to @access_account, notice: 'Access Account was successfully created.' }
        format.json { render :show, status: :created, location: @access_account }
      else
        format.html { render :new }
        format.json { render json: @access_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_accounts/1
  # PATCH/PUT /access_accounts/1.json
  def update
    respond_to do |format|
      if @access_account.update(access_account_params)
        if access_account_params.dig(:permissions_attributes)
          access_account_params.dig(:permissions_attributes).each do |val, permission_attributes|
            if permission_attributes[:_destroy] == '1'
              permission = Permission.find(permission_attributes[:id])
              @access_account.permissions.destroy(permission)
            end
          end
        end
        format.html { redirect_to @access_account, notice: 'Access Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_account }
      else
        format.html { render :edit }
        format.json { render json: @access_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_accounts/1
  # DELETE /access_accounts/1.json
  def destroy
    @access_account.destroy
    respond_to do |format|
      format.html { redirect_to access_accounts_url, notice: 'Access Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_access_account
    @access_account = AccessAccount.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def access_account_params
    params.require(:access_account).permit(:name, :approver_id, :approvable, permissions_attributes: [:id, :access_account_id, :name, :_destroy])
  end
end
