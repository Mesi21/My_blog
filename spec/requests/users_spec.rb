require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'should get all the users of the app' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    it 'should render the index page with every existing user' do
      get '/users'
      expect(response).to render_template('index')
    end

    it 'should render the index page with correct text in the body' do
      get '/users'
      expect(response.body).to include('ALL OUR')
    end

    it 'should render the show page with specifics of one user' do
      get '/users/1'
      expect(response).to have_http_status(200)
    end

    it 'should render the show page with specifics of one user' do
      get '/users/1'
      expect(response).to render_template('show')
    end

    it 'should render the show page with specifics of one user' do
      get '/users/1'
      expect(response.body).to include('Number of posts')
    end
  end
end
