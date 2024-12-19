# frozen_string_literal: true

FactoryBot.define do
  factory :participant, class: "Survey::Participant" do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    corporate_email { Faker::Internet.email }
    department { Faker::Company.department }
    position { "intern" }
    function { "professional" }
    location { "brasilia" }
    company_tenure { "Between 1 and 2 years" }
    gender { "male" }
    generation { "generation z" }
    lv0_company { "Company 1" }
    lv1_directorate { "Directorate 1" }
    lv2_management { "Management 1" }
    lv3_coordination { "Coordination 1" }
    lv4_area { "Area 1" }
    association(:survey)
  end
end
