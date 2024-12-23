# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable,
    :registerable, :recoverable, :rememberable, :validatable,
    # LUCAS: What?! Something are only possible with GPT assistance, I never had a situation like that, normally when I create APIs I use regular jwt gem
    jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
