require 'rails_helper'

RSpec.describe "Admin Show" do
  describe "As an admin" do
    before :each do
        @merchant_1 = Merchant.create!(name: "Johns Tools")
        @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
    end

    it 'us#25 - I see the name of that merchant' do
        visit admin_merchant_path(@merchant_1)
        expect(page).to have_content(@merchant_1.name)
    end

    describe "I visit a merchant's admin show page" do
      
      it "I see a link to update the merchant's information" do
        visit admin_merchant_path(@merchant_1)

        expect(page).to have_link("Update")
      end

      it "When I click the link, I am taken to a page to edit this merchant" do
        visit admin_merchant_path(@merchant_1)

        click_link"Update"

        expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
      end
      
      it "I see a form filled in with the existing merchant attribute information" do 
        visit edit_admin_merchant_path(@merchant_1)
        
        expect(page).to have_field("Name", {with: "#{@merchant_1.name}"})
      end

      it "When I update the information in the form and I click ‘submit’, I am redirected back to the merchant's admin show page where I see the updated information and I see a flash message stating that the information has been successfully updated" do
        visit edit_admin_merchant_path(@merchant_1)
        save_and_open_page
        fill_in "Name",	with: "Billy Johns Tools"
        click_button"Update Merchant"
      end
    end
  end
end