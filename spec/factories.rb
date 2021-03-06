FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

  factory :forum do
    sequence(:name) { |n| "Forum #{n}" }
    sequence(:subname) { |n| "This is forum #{n}" }
    creator "Foo"
  end

  factory :post do
    content "Lorem ipsum"
    title "Foo"
    user_id 1
    forum
  end
end