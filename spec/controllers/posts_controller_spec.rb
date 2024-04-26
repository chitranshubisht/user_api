require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new post' do
        expect {
          post :create, params: { post: { title: 'Test Title', description: 'Test Description' } }
        }.to change(Post, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: { post: { title: 'Test Title', description: 'Test Description' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new post' do
        expect {
          post :create, params: { post: { title: nil, description: 'Test Description' } }
        }.not_to change(Post, :count)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: { post: { title: nil, description: 'Test Description' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    it 'returns a list of posts' do
      # Create posts directly in the database
      Post.create(title: 'Title 1', description: 'Description 1')
      Post.create(title: 'Title 2', description: 'Description 2')
      Post.create(title: 'Title 3', description: 'Description 3')

      get :index
      expect(response).to have_http_status(:ok)
      expect(assigns(:posts).count).to eq(3)
    end
  end
end
