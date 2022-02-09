require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
    

  scenario "They click on add button and cart updates" do
    # ACT
    visit root_path
    # DEBUG / VERIFY
    save_screenshot
    
    expect(page).to have_content('My Cart (0)')
    click_button 'Add'
    expect(page).to have_content('My Cart (1)')

  end
end