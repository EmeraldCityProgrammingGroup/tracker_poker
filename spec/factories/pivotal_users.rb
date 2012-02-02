# Read about factories at http://github.com/thoughtbot/factory_girl
require 'digest/md5'

FactoryGirl.define do
  factory :pivotal_user do
    sequence(:token) {|x| Digest::MD5.hexdigest("Number #{x}") }
    association :user
  end
end
