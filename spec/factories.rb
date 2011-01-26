Factory.define :user do |user|
  
  user.name                   "Steve Boj"
  user.email                  "steveb@yahoo.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
  
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end