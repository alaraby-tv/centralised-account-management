module ApplicationHelper
  def label_class(state)
    case state
    when 'submitted'
      'primary'
    when 'resubmitted'
      'info'
    when 'approved'
      'warning'
    when 'rejected'
      'danger'
    when 'granted'
      'success'
    else
      'default'
    end
  end
end
