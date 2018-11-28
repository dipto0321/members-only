module ApplicationHelper
  def full_title(title)
    @base = 'Members Only'
    page_title = title.nil? ? @base : title + ' | ' + @base
  end
end
