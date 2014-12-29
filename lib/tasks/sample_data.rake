# -*- coding: utf-8 -*-
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_teams
    make_relationships
  end

  def make_users
    password = "foobar"
    gender = "男"
    department =  "电子系"
    from_class =  "无210"
    20.times do |n|
      name = "韩大狗-#{n+1}"
      email = "doggie-#{n+1}@example.com"
      User.create!(name: name, 
                   email: email,
                   gender: gender,
                   phone_num: n,
                   department: department,
                   from_class: from_class,
                   password: password,
                   password_confirmation: password)
    end
    gender = "女"
    department =  "精仪系"
    from_class =  "精21"
    20.times do |n|
      name = "李莫愁-#{n+1}"
      email = "sad-#{n+1}@example.com"
      User.create!(name: name, 
                   email: email,
                   gender: gender,
                   phone_num: n,
                   department: department,
                   from_class: from_class,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_teams
    Team.create!(name: "变态不安定委员会", group: "单片机组")
    Team.create!(name: "报复老大哥组", group: "FPGA组")
  end

  def make_relationships
    users = User.all
    teams = Team.all
    members = users[0..3]
    members.each { |member| teams[0].add_member!(member)}
    teams[0].leader_id= users[0].id
    teams[0].save
    members = users[22..25]
    members.each { |member| teams[1].add_member!(member)}
    teams[1].leader_id= users[22].id
    teams[1].save
  end
end
