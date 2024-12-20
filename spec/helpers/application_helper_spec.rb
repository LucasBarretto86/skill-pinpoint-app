# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  it "#field_error_message" do
    record = double(:record, errors: { name: ["can't be blank"] })
    expect(helper.field_error_message(record, :name)).to eq("<p class=\"error-message\">can&#39;t be blank</p>")
  end
end
