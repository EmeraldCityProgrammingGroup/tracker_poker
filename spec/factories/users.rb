# Read about factories at http://github.com/thoughtbot/factory_girl
require 'digest/md5'

FactoryGirl.define do
  factory :user do
    #name "Allan Davis"
    sequence(:email ){|n| "test#{n}@trackerpoker.com"}
    password "password"
    password_confirmation "password"
    authentication_token Digest::MD5.hexdigest("Hello World\n")
    #pivotal_users {|u| [u.association(:pivotal_user)]}
  end
  
end
