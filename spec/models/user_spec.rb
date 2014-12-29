# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  department             :string(255)
#  from_class             :string(255)
#  gender                 :string(255)
#  remember_token         :string(255)
#  phone_num              :integer
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  id_num                 :integer
#  admin                  :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
  before {    @user = User.new(name: "厂长",
                               email: "user@example.com",
                               gender: "男", 
                               from_class: "无210",
                               department: "电子系",
                               password: "foobar",
                               password_confirmation: "foobar") }


  subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:class) }
  it { should respond_to(:gender) }
  it { should respond_to(:department) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}

  it { should respond_to(:membership) }
  it { should respond_to(:team) }


  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " "}
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "当系别不以系字结尾" do
    before { @user.department = "洗衣机"}
    it { should_not be_valid }
  end

  describe "当性别为其他" do
    before { @user.gender = "洗衣机"}
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  describe "when email has uppercase" do
    let(:mixed_case_email) {"ABC@asd221A.coM"}
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org example.user@foo.jp fo+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken, but upcased " do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  describe "when password is not present" do
    before do
      @user.password = @user.password_confirmation = " " 
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before do
      @user.password_confirmation = "mismatch" 
    end
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before do
      @user.password_confirmation =  nil
    end
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before do
      @user.password = @user.password_confirmation = "a" * 5
    end
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before do
      @user.save
    end
    let(:found_user) { User.find_by_email (@user.email)}
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password)}
    end

    describe "with valid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid")}

      it { should_not eq user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "加入队伍后" do
    let(:team) {  FactoryGirl.create(:team) }
    before do
      @user.save
      team.add_member!(@user)
    end

    its(:team) { should eq team }

    describe "被踢后" do
      before {team.kick_member!(@user)}

      its(:team) { should be_nil }
    end
  end
end
