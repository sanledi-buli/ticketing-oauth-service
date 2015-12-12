FactoryGirl.define do
  factory :customer do
    first_name "foo"
    last_name "bar"
    mobile_phone 18120000000
    sequence(:email) { |n| "foo#{n}@bar.com" }
    card_id "abc"
    status 1
    address "Jln. foo"
    city "Jakarta"
    country "Indonesia"
    nationality "Indonesia"
    password "Qwerty1234"
  end
end