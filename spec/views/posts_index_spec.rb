require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
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
  let!(:post5) do
    Post.create!(author: first_user, title: 'Post #5',
                 text: 'the fifth post of the first_user that has way more than nighty characters
                 to check if the whole post is displayed or not on this page.',
                 comments_counter: 0, likes_counter: 7)
  end

  before do
    visit user_posts_path(first_user)
  end

  it 'displays the username of the first_user' do
    expect(page).to have_content(first_user.name)
  end

  it 'displays the profile picture of the user' do
    expect(page).to have_css("img[src='https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM']")
  end

  it 'displays the number of posts through the posts_counter' do
    expect(page).to have_content("Number of posts: #{first_user.posts_counter}")
  end

  it 'display the post title' do
    expect(page).to have_content(post1.title)
  end

  it 'displays a certain amount of text from the post' do
    expect(page).to have_content(post1.text)
  end

  it 'displays the latest five comments of a post truncated to 90 characters' do
    post1.last_five_comments.each do |c|
      expect(page).to have_content(c.text)
      expect(page).to_not have_content(c.text[-1, 1])
    end
  end

  it 'displays the number of comments' do
    expect(page).to have_content("Comments: #{post1.comments_counter}")
  end

  it 'displays the number of likes on a post' do
    expect(page).to have_content("Likes: #{post2.likes_counter}")
  end

  it 'has a button View post' do
    expect(page).to have_selector(:link_or_button, 'View post')
  end

  it 'should redirect to the post show page through the View post button' do
    click_link(href: user_post_path(first_user, post1))
    expect(page).to have_current_path(user_post_path(first_user, post1.id))
  end

  it 'should display a pagination button' do
    expect(page).to have_button('Pagination')
  end
end
