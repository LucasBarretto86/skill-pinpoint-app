# frozen_string_literal: true

module ApplicationHelper
  def field_error_message(model, field)
    return unless model.errors[field].any?

    content_tag(:p, model.errors[field].first, class: "error-message")
  end
end
