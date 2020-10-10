FactoryBot.define do
  factory :session do
    Workout { nil }
    count { "" }
    active_time { "MyString" }
    rest_time { "MyString" }
    total_time { "MyString" }
  end
end
