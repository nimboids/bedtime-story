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

  def formatted_countdown day_fraction
    full_hours, minutes, seconds, frac = Date.day_fraction_to_time(day_fraction)
    days = full_hours/24
    hours = full_hours%24

    %(<div class="countdown">
      <div class="number" id="countdown_days">#{days}</div>
      <div class="text">days</div>
      <div class="number" id="countdown_hours">#{hours}</div>
      <div class="text">hours</div>
      <div class="number" id="countdown_minutes">#{minutes}</div>
      <div class="text">minutes</div>
      <div class="number" id="countdown_seconds">#{seconds}</div>
      <div class="text">seconds</div>
    </div>)
  end

  def preload_images
    Dir["#{RAILS_ROOT}/public/images/*-active.png"].map do |file|
      %(<img src="/images/#{File.basename file}" alt="" class="hidden" />)
    end.join "\n"
  end
end
