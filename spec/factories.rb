# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "赵无定#{n}" }
    sequence(:email) { |n| "doggie_#{n}@ex.com" }
    gender "男"
    department "电子系"
    from_class "无210"
    password "foobar"
    password_confirmation "foobar"
  end
  factory :team do
    sequence(:name) { |n| "小朋友喜欢大姐姐#{n}" }
    group "单片机组"
  end
end
