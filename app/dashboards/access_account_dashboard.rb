require "administrate/base_dashboard"

class AccessAccountDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    approver: Field::BelongsTo.with_options(class_name: "User"),
    access_requests: Field::HasMany,
    requests: Field::HasMany,
    end_users: Field::HasMany,
    access_account_permissions: Field::HasMany,
    permissions: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    approvable: Field::Boolean,
    approver_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  approver
  access_requests
  requests
  end_users
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  approver
  access_requests
  requests
  end_users
  access_account_permissions
  permissions
  id
  name
  approvable
  approver_id
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  approver
  access_requests
  requests
  end_users
  access_account_permissions
  permissions
  name
  approvable
  approver_id
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

  # Overwrite this method to customize how access accounts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(access_account)
  #   "AccessAccount ##{access_account.id}"
  # end
end
