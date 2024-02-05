require 'rails_helper'
RSpec.describe 'posts#show', type: :feature do
  let(:first_user) { User.create!(name: 'Mesi', photo: 'https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM', bio: 'Mesi\'s biography', posts_counter: 3) }
  let(:second_user) { User.create!(name: 'Mesi', photo: 'https://unsplash.com/photos/a-group-of-people-holding-a-teddy-bear-together-FAqkG14YOKM', bio: 'Mesi\'s biography', posts_counter: 3) }
  let!(:post1) do
    Post.create!(author: second_user, title: 'Post #1', text: 'some text', comments_counter: 2, likes_counter: 1)
  end
  let!(:comment) { Comment.create!(user: second_user, post: post1, text: 'This is a comment on the post1') }
  let!(:like) { Like.create!(user: second_user, post: post1) }
  before do
    visit user_post_path(first_user, post1)
  end
  it 'displays the title of the post on the page' do
    expect(page).to have_content(post1.title)
  end
  it 'displays the author\'s name' do
    expect(page).to have_content(post1.author.name)
  end
  it 'displays the the text of the post' do
    expect(page).to have_content(post1.text)
  end
  it 'displays the the text of the post' do
    expect(page).to have_content('some text')
  end
  it 'displays the number of comments on the post' do
    expect(page).to have_content("Comments: #{post1.comments_counter}")
  end
  it 'displays the username of each person the comments belong to' do
    expect(page).to have_content(post1.comments.first.user.name)
  end
  it 'displays the number of likes of the post' do
    expect(page).to have_content("Likes: #{post1.likes_counter}")
  end
  it 'displays all the comments' do
    expect(page).to have_content(post1.comments.first.text)
  end
  it 'displays a button for adding a new comment' do
    expect(page).to have_selector(:link_or_button, 'Add comment')
  end
  it 'displays a button to Like the post' do
    expect(page).to have_selector(:link_or_button, 'Like')
  end
end
