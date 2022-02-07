require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'checks if there is no name for new records' do
      @category = Category.new
      @product = Product.new
      expect(@product.name).to be_nil
    end

    it "ensures that a product with all four fields set will indeed save successfully" do
      @category = Category.new(name: 'Electronics')
      @product = Product.new(name: 'Watch', category: @category, quantity: 1, price: 300)
      @product.save!
      expect(@product).to be_valid
  end 
      it 'ensure that the name should be present' do
        @category = Category.new(name: "Electronics")
        @product = Product.new(name: nil, category:  @category, quantity: 1, price: 300)
        expect(@product.errors[:name]).not_to  include("cannot be blank")
      end

    it 'ensure that the price should be present' do
      @category = Category.new(name: "Electronics")
      @product = Product.new(name: "Watch", category:  @category, quantity: 1, price: nil)
      expect(@product.errors[:price]).not_to  include("cannot be blank")
    end

    it 'ensure the quantity should be present' do
      @category = Category.new(name: "Electronics")
      @product = Product.new(name: "Watch", category:  @category, quantity: nil, price: 300)
      expect(@product.errors[:quantity]).not_to  include("cannot be blank")
    end

    it 'ensures that the category cant be blank' do
      @category = Category.new
      @product = Product.new({name: 'Watch', quantity: 1, price: 400})
      expect(@product).not_to be_valid
      expect(@product.errors.messages).to eq ({:category => ["can't be blank"]})
    end
  end
end