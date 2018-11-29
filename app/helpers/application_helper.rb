module ApplicationHelper
  def full_title(title)
    @base = 'Members Only'
    page_title = title.nil? ? @base : title + ' | ' + @base
  end

  def cancel_path
    cancel_redirect_path = params[:controller] == "posts" ? user_path(current_user.id) : root_path 

    params[:action] == 'edit' ? user_path(current_user.id): cancel_redirect_path
  end

  def display_delete
    
    params[:action] == 'edit' ? nil : 'display-none'
  end
end
