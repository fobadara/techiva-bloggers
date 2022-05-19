require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    visit user_session_path
    @photo = 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/microsoft/58/ballot-box-with-x_2612.png'
    @user1 = User.create(name: 'John Doe', photo: @photo, email: 'joe@mail.com', password: '123456', posts_count: 0)
    @user2 = User.create(name: 'Michael Smith', photo: @photo, email: 'michal@mail.com', password: '123456', posts_count: 0)
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log in'
    visit users_path
    sleep 3
  end

  it 'displays the username of all users' do
    expect(page).to have_content 'John Doe'
    expect(page).to have_content 'Michael Smith'
  end

  it 'it displays the profile picture for each user.' do
    images = page.all('img')
    user_names = page.all('div h4')
    expect(images.size).to eql(user_names.size)  
  end

  it 'It displays the number of posts each user has written.' do
    posts = page.all('div p')
    expect(posts[0]).to have_content 'Number of posts: 0'
    expect(posts[1]).to have_content 'Number of posts: 0'
  end

  it 'redirects the user to the show page when a user is clicked.' do
    click_link 'John Doe'
    expect(page).to have_current_path user_path(@user1)
  end
end
