json.extract! request, :id, :end_user_id, :requester_id, :access_account_id, :permission_id, :state, :approver_name, :note, :created_at, :updated_at
json.url request_url(request, format: :json)
