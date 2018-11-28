module UsersHelper
  def cancel_path
    params[:action] == 'edit' ? user_path : root_path
  end

  def display_delete
    params[:action] == 'edit' ? nil : 'display-none'
  end
end
