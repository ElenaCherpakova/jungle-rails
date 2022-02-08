require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validations' do
    it 'is valid with valid attributes' do
      @user = User.new(first_name: 'Mark', last_name: 'Bo', email: 'm@example.com', password: '12345', password_confirmation: '12345')
      expect(@user).to be_valid
    end

    it 'is not valid without first name' do
      @user = User.new(first_name: nil, last_name: 'Bo', email: 'm@example.com', password: '12345', password_confirmation: '12345')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq(["First name can't be blank"])
    end

    it 'is not valid without last name' do
      @user = User.new(first_name: 'Mark', last_name: nil, email: 'm@example.com', password: '12345', password_confirmation: '12345')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq(["Last name can't be blank"])
    end

      it "is not valid if password and password confimation dont match" do
        @user = User.create(first_name: 'Mark', last_name: 'Bo', email: 'm@example.com', password: '12345', password_confirmation: '56879')
        expect(@user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
      end

    it 'is not valid without email' do
      @user = User.new(first_name:'Mark', last_name: 'Bo', email: nil, password: '12345', password_confirmation: '12345')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq(["Email can't be blank"]) 
    end

    it 'is not valid without password' do
      @user = User.new(first_name:'Mark', last_name: 'Bo', email: 'm@example.com', password: nil, password_confirmation: '12345')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Password can't be blank")

    end


    it 'is not valid without password confirmation' do
      @user = User.new(first_name:'Mark', last_name: 'Bo', email: 'm@example.com', password: '12345', password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Password confirmation can't be blank")
      
    end

    it 'password must have a minimum length' do
      @user = User.new(first_name:'Mark', last_name: 'Bo', email: 'markbo@example.com', password: '123', password_confirmation: '123')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq(["Password is too short (minimum is 5 characters)"])
    end

    it 'email should not repeat' do
      @user = User.create(first_name: 'Bob', last_name: 'Ben', email: 'TEST@TEST.com', password: '12345', password_confirmation: '12345')
      @newuser = User.new(first_name: 'Mark', last_name: 'Bo', email: 'test@test.COM', password: '12345', password_confirmation: '12345')
      @newuser.save
      expect(@newuser.errors.full_messages).to eq(["Email has already been taken"])
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should pass with valid credentials' do
    @user = User.create(first_name: 'Bob', last_name: 'Ben', email: 'bobben@example.com', password: '12345', password_confirmation: '12345')
    expect(User.authenticate_with_credentials('bobben@example.com', '12345')).not_to be(nil)
    end
    it 'should pass with uppercase in email' do
      @user = User.create(first_name: 'Bob', last_name: 'Ben', email: 'bobben@example.com', password: '12345', password_confirmation: '12345')
      expect(User.authenticate_with_credentials('BOBBEN@example.com', '12345')).not_to be(nil)
    end
    it 'should pass if few spaces before and/or after in email' do
      @user = User.create(first_name: 'Bob', last_name: 'Ben', email: 'bobben@example.com', password: '12345', password_confirmation: '12345')
      expect(User.authenticate_with_credentials(" bobben@example.com ", '12345')).not_to be(nil)
    end
  end
end