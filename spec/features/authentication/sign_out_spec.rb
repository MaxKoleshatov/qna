require 'rails_helper'

feature 'User can sign owt' do

  given(:user) {create(:user)}

  scenario 'The user can log out of the system' do
    
    sign_in(user)

    click_on 'Log owt'

    expect(page).to have_content 'Signed out successfully.'
  end
  end