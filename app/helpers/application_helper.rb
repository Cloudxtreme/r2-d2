module ApplicationHelper

  def full_title(page_title = '')
    base_title = "R2-D2"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

end
