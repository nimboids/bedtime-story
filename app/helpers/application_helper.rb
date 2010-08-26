# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title title = nil
    if title
      @title = title
    elsif @title
      "Byte Night Bedtime Story &ndash; #{@title}"
    else
      "Byte Night Bedtime Story"
    end
  end

  def link_to_home
    link_class = (controller.controller_name == "home") ? "home_active" : "home_inactive"
    %(<li><a href="/" id="#{link_class}"><span>Home</span></a>)
  end

  def link_to_page page, label
    link_class = if controller.controller_name == "pages" && controller.params[:page] == page
                   "#{page}_active"
                 else
                   "#{page}_inactive"
                 end
    %(<li><a href="/#{page}" id="#{link_class}"><span>#{label}</span></a>)
  end
end
