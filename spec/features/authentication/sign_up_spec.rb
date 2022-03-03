require 'rails_helper'

feature 'User can sign up' do

  scenario 'The user can register of the system' do

    sign_up

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
  end