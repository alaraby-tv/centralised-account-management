require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    invited_by: Field::Polymorphic,
    role: Field::BelongsTo,
    access_accounts: Field::HasMany,
    requests: Field::HasMany,
    access_requests: Field::HasMany,
    id: Field::Number,
    first_name: Field::String,
    last_name: Field::String,
    name: Field::String,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    invitation_token: Field::String,
    invitation_created_at: Field::DateTime,
    invitation_sent_at: Field::DateTime,
    invitation_accepted_at: Field::DateTime,
    invitation_limit: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  name
  role
  access_accounts
  access_requests
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  invited_by
  role
  access_accounts
  requests
  access_requests
  id
  first_name
  last_name
  email
  encrypted_password
  reset_password_token
  reset_password_sent_at
  remember_created_at
  sign_in_count
  current_sign_in_at
  last_sign_in_at
  current_sign_in_ip
  last_sign_in_ip
  invitation_token
  invitation_created_at
  invitation_sent_at
  invitation_accepted_at
  invitation_limit
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  invited_by
  role
  access_accounts
  requests
  access_requests
  first_name
  last_name
  email
  encrypted_password
  reset_password_token
  reset_password_sent_at
  remember_created_at
  sign_in_count
  current_sign_in_at
  last_sign_in_at
  current_sign_in_ip
  last_sign_in_ip
  invitation_token
  invitation_created_at
  invitation_sent_at
  invitation_accepted_at
  invitation_limit
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    user.name
  end
end
