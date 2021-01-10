module ApplicationHelper
  def label_class(state)
    case state
    when 'submitted'
      'primary'
    when 'resubmitted'
      'info'
    when 'approved'
      'success'
    when 'rejected'
      'danger'
    when 'granted'
      'warning'
    else
      'default'
    end
  end
end
