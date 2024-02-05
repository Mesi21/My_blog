require 'rails_helper'

describe 'User Index Page Features', type: :feature, js: true do
  let(:new_user) { User.create!(name: 'Mesi Molnar', photo: 'https://unsplash.com/photos/woman-wearing-black-camisole-top-walking-on-grass-field-during-sunrise-2FrX56QL7P8', bio: 'Description of the first user\'s biography.', posts_counter: 2) }
  let!(:post1) do
    Post.create!(author: new_user, title: 'Post #1', text: 'some text', comments_counter: 2, likes_counter: 1)
  end
  let!(:post2) do
    Post.create!(author: new_user, title: 'Post #2', text: 'another post content', comments_counter: 2,
                 likes_counter: 1)
  end
  before :each do
    visit users_path
  end

  it 'displays a button to add a new post on behalf of the first user' do
    expect(page).to have_selector(:link_or_button, '+ Add new post logged in as current user with id: 1')
  end

  it 'lists the username of all other users' do
    expect(page).to have_content(new_user.name)
  end

  it 'lists the profile picture for each users' do
    expect(page).to have_all_of_selectors('.user-photo')
  end

  it 'lists the number of posts of the user' do
    expect(page).to have_content('Number of posts:')
    expect(page).to have_content(new_user.posts_counter)
  end

  it 'the name of the user redirects to the user\'s show page' do
    click_link(href: user_path(new_user))
    expect(page).to have_current_path(user_path(new_user))
  end
end
