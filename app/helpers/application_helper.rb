module ApplicationHelper
  def full_title(title)
    @base = 'Microverse Forum'
    page_title = title.nil? ? @base : title + ' | ' + @base
  end

  def cancel_path
    cancel_redirect_path = params[:controller] == "posts" ? user_path(current_user.id) : root_path 

    params[:action] == 'edit' ? user_path(current_user.id): cancel_redirect_path
  end

  def display_delete
    
    params[:action] == 'edit' ? nil : 'display-none'
  end

  def author(post)
    author = User.find_select_user(post.user_id)
  end

  def user_post(post)
    user_post_path(post.user_id, post)
  end
end
