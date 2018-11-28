module ApplicationHelper
  def full_title(title)
    @base = 'Members Only'
    page_title = title.nil? ? @base : title + ' | ' + @base
  end

  def cancel_path
    params[:action] == 'edit' ? user_path : root_path
  end

  def display_delete
    params[:action] == 'edit' ? nil : 'display-none'
  end
end
