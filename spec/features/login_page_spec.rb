require 'rails_helper'

RSpec.describe 'Login page', js: true do
  before(:each) do
    visit new_user_session_path
  end
  it 'can see the username and password inputs and the "Submit" button.' do
    expect(page).to have_field('Email', type: 'email')
    expect(page).to have_field('Password', type: 'password')
    expect(page).to have_button('Log in', type: 'submit')
  end

  it 'shows a detailed error when I click the submit button without filling in the username or password.' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'shows a  detailed error when I click the submit button after filling in the username and the password with incorrect data.' do
    fill_in 'Email', with: 'me@gmail.com'
    fill_in 'Password', with: 'rty'
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'redirects me to the root page when I click the submit button after filling in the username and the password with correct data.' do
    fill_in 'Email', with: 'fobadara@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    visit root_path
  end
end
