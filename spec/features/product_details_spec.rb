require 'rails_helper'

RSpec.feature "Visitor navigates to home page and clicks on link to details", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

  end

  scenario "They can navigates from the home page to the product details" do
    # ACT
    visit root_path

    # DEBUG
    # save_screenshot

    # VERIFY
    find_link("Details").trigger("click")
    
    # page.find('.products').first(:link,'Details').click
    expect(page).to have_css 'section.products-show'
    save_screenshot
  end
end