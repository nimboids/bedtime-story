class DummyController < ApplicationController
  def dummy
    render :nothing
  end

  def raise_routing_error
    raise ActionController::RoutingError.new(%w(foo bar), "foo")
  end

  def raise_unknown_action
    raise ActionController::UnknownAction
  end

  def raise_missing_template
    raise ActionView::MissingTemplate.new(%w(foo bar), "foo")
  end
end
