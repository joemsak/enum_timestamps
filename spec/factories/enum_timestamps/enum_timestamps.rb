FactoryBot.define do
  factory :enum_timestamp do
    association(:model, factory: :user)
    field_name { :status }
    identifier { 0 }
  end
end
