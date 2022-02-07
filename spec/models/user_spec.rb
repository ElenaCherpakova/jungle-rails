require 'rails_helper'

RSpec.describe UserSpec, type: :model do
  describe 'User Validations' do
    it 'tries to create a valid user' do
      @user = User.new(first_name: 'Mark', last_name: 'Bo', email: 'm@example.com', password: '123', password_confirmation: '123')
      @user.save
      expect(@user).to be_valid
    end
  end
end