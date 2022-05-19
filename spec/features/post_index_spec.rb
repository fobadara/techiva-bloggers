require 'rails_helper'

# I can see the user's profile picture.
# I can see the user's username.
# I can see the number of posts the user has written.
# I can see a post's title.
# I can see some of the post's body.
# I can see the first comments on a post.
# I can see how many comments a post has.
# I can see how many likes a post has.
# I can see a section for pagination if there are more posts than fit on the view.
# When I click on a post, it redirects me to that post's show page.

RSpec.describe "Post's Index Page" do
  before(:each) do
    visit user_session_path
    @photo = 'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/microsoft/58/ballot-box-with-x_2612.png'

    @user1 = User.create!(
      name: 'John Doe', bio: 'This is John Doe bio', photo: @photo, email: 'joe@mail.com',
      password: '123456', posts_count: 2
    )
    @user2 = User.create!(
      name: 'Michal Smith', bio: 'This is Michal Smith bio', photo: @photo,
      email: 'michal@mail.com', password: '123456', posts_count: 0
    )

    fill_in 'Email', with: 'joe@mail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    # Posts

    @post1 = @user1.posts.create!(
      title: 'Education', text: 'This is first Educat post!', comments_count: 0, likes_count: 0
    )
    @post2 = @user1.posts.create!(
      title: 'Sport', text: 'This is second Sport post!', comments_count: 0, likes_count: 0
    )
    @post3 = @user2.posts.create!(
      title: 'Bussiness', text: 'This is third!', comments_count: 0, likes_count: 0
    )

    # Comments

    @user1.comments.create!(text: 'Really nice post', post: @post1)
    @user2.comments.create!(text: 'Amezing', post: @post1)
    @user2.comments.create!(text: 'Fantastic', post: @post2)

    @user1.likes.create!(post: @post1)
    @user1.likes.create!(post: @post2)
    @user2.likes.create!(post: @post1)
    @user2.likes.create!(post: @post3)

    visit user_posts_path(@user1)
  end

  it 'displays the user\'s profile picture' do
    image = page.find('img')['src']
    expect(image).to eql @photo
  end

  it 'it displays user\'s username' do
    expect(page).to have_content 'John Doe'
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content('Number of posts: 2')
  end

  it 'displays some post\'s titles.' do
    expect(page).to have_content 'Education'
    expect(page).to have_content 'Sport'
  end

  it 'displays some of the post\'s body.' do
    expect(page).to have_content 'This is first Educat post!'
    expect(page).to have_content 'This is second Sport post!'
  end

  it 'displays the first comments on a post.' do
    expect(page).to have_content 'Really nice post'
  end

  it 'displlays how many comments a post has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'displays how many likes a post has' do
    expect(page).to have_content('Likes: 2')
  end

  it 'displays a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_content('Pagination')
  end

  it 'it redirects me to that post\'s show page, when I click on a post.' do
    click_link 'Education'
    expect(page).to have_current_path user_post_path(@user1, @post1)
  end
end
