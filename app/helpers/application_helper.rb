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
end
