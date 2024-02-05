require 'rails_helper'

RSpec.feature 'Users Show', type: :feature do
  let(:first_user) { User.create!(name: 'Mesi', photo: 'https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM', bio: 'Mesi\'s biography', posts_counter: 3) }
  let!(:post1) do
    Post.create!(author: first_user, title: 'Post #1', text: 'some text', comments_counter: 2, likes_counter: 1)
  end
  let!(:post2) do
    Post.create!(author: first_user, title: 'Post #2', text: 'another post content', comments_counter: 2,
                 likes_counter: 1)
  end
  let!(:post3) do
    Post.create!(author: first_user, title: 'Post #3', text: 'a new post with some interesting stuff',
                 comments_counter: 3, likes_counter: 0)
  end
  let!(:post4) do
    Post.create!(author: first_user, title: 'Post #4', text: 'a post that should not be present on this page',
                 comments_counter: 5, likes_counter: 10)
  end
  before do
    visit user_path(first_user)
  end
  it 'redirects to the post show page when you click on the button See all posts' do
    first('#btn-view-post').click
    expect(current_path).to eq(user_post_path(first_user, first_user.last_three_posts.first))
  end
  it 'redirects to the index page of the posts on button click"' do
    click_link 'View more posts'
    expected_path = user_posts_path(first_user)
    actual_path = page.current_path
    expect(actual_path).to eq(expected_path)
  end
end

RSpec.feature 'Users Show', type: :feature do
  let(:first_user) { User.create!(name: 'Mesi', photo: 'https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM', bio: 'Mesi\'s biography', posts_counter: 3) }
  let!(:post1) do
    Post.create!(author: first_user, title: 'Post #1', text: 'some text', comments_counter: 2, likes_counter: 1)
  end
  let!(:post2) do
    Post.create!(author: first_user, title: 'Post #2', text: 'another post content', comments_counter: 2,
                 likes_counter: 1)
  end
  let!(:post3) do
    Post.create!(author: first_user, title: 'Post #3', text: 'a new post with some interesting stuff',
                 comments_counter: 3, likes_counter: 0)
  end
  let!(:post4) do
    Post.create!(author: first_user, title: 'Post #4', text: 'a post that should not be present on this page',
                 comments_counter: 5, likes_counter: 10)
  end
  before do
    visit user_path(first_user)
  end
  it 'should be displayed on the users_show page' do
    expect(page).to have_content('Mesi')
    expect(page).to have_content(first_user.posts_counter)
    expect(page).to have_link('View more posts')
    expect(page).to have_content(first_user.bio)
    expect(page).to have_css('img[src="https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM"]')
  end
end

RSpec.feature 'Users Show', type: :feature do
  let(:first_user) { User.create!(name: 'Mesi', photo: 'https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM', bio: 'Mesi\'s biography', posts_counter: 3) }
  let!(:post1) do
    Post.create!(author: first_user, title: 'Post #1', text: 'some text', comments_counter: 2, likes_counter: 1)
  end
  let!(:post2) do
    Post.create!(author: first_user, title: 'Post #2', text: 'another post content', comments_counter: 2,
                 likes_counter: 1)
  end
  let!(:post3) do
    Post.create!(author: first_user, title: 'Post #3', text: 'a new post with some interesting stuff',
                 comments_counter: 3, likes_counter: 0)
  end
  let!(:post4) do
    Post.create!(author: first_user, title: 'Post #4', text: 'a post that should not be present on this page',
                 comments_counter: 5, likes_counter: 10)
  end
  before do
    visit user_path(first_user)
  end
  it 'displays ownly the user\'s last three posts' do
    first_user.last_three_posts.each do
      expect(page).to have_content(post4.text)
      expect(page).to have_content(post3.text)
      expect(page).to have_content(post2.text)
      expect(page).to_not have_content(post1.text)
    end
  end
end

RSpec.feature 'Users Show', type: :feature do
  let(:first_user) { User.create!(name: 'Mesi', photo: 'https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM', bio: 'Mesi\'s biography', posts_counter: 3) }
  let!(:post1) do
    Post.create!(author: first_user, title: 'Post #1', text: 'some text', comments_counter: 2, likes_counter: 1)
  end
  let!(:post2) do
    Post.create!(author: first_user, title: 'Post #2', text: 'another post content', comments_counter: 2,
                 likes_counter: 1)
  end
  let!(:post3) do
    Post.create!(author: first_user, title: 'Post #3', text: 'a new post with some interesting stuff',
                 comments_counter: 3, likes_counter: 0)
  end
  let!(:post4) do
    Post.create!(author: first_user, title: 'Post #4', text: 'a post that should not be present on this page',
                 comments_counter: 5, likes_counter: 10)
  end
  before do
    visit user_path(first_user)
  end
  it 'checks if the button to see all the posts exists on the page' do
    expect(page).to have_selector(:link_or_button, 'View more posts')
  end
end
