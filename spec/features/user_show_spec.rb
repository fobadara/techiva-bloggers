require 'rails_helper'

RSpec.describe 'User Show Page' do
  before(:each) do
    visit user_session_path

    @photo = 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/microsoft/58/ballot-box-with-x_2612.png'
    @user1 = User.create(name: 'John Doe', photo: @photo, bio: 'Lorem ipsum dolor sit amet', email: 'joe@mail.com', password: '123456', posts_count: 3)

    @post1 = @user1.posts.create!(title: 'Animal', text: 'lorem_one', comments_count: 0, likes_count: 0)
    @post2 = @user1.posts.create!(title: 'Population', text: 'lorem_two', comments_count: 0, likes_count: 0)
    @post3 = @user1.posts.create!(title: 'Science', text: 'lorem_one', comments_count: 0, likes_count: 0)

    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log in'

    visit user_path(@user1)
  end

  # it 'displays the user\'s profile picture' do
  #   img_src = page.find('img')['src']
  #   expect(img_src).to eql(@photo)
  # end

  # it 'it displays the user\'s username' do
  #   expect(page).to have_content 'John Doe'
  # end

  # it 'It displays the number of posts the user has written' do
  #   expect(page).to have_content 'Number of posts: 3'
  # end

  # it 'shows the user\'s bio' do
  #   expect(page).to have_content 'Lorem ipsum dolor sit amet'
  # end
  
  # it 'displays the user\'s first 3 posts.' do
  #   expect(page).to have_content 'lorem_one'
  #   expect(page).to have_content 'lorem_two'
  #   expect(page).to have_content 'lorem_one'
  # end

  it 'has a button  that lets me view all of a user\'s posts' do
    expect(page).to have_content 'See all posts'
  end

  it 'redirects me to the user\'s post\'s index page, when I click to see all posts.' do
    click_link 'See all posts'
    expect(page).to have_current_path user_posts_path(@user1)
  end
end
