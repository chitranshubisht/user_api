# spec/controllers/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new post' do
        post_params = FactoryBot.attributes_for(:post)
        expect {
          post :create, params: { post: post_params }
        }.to change(Post, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new post' do
        post_params = { title: '', description: '' } # Invalid attributes
        expect {
          post :create, params: { post: post_params }
        }.to_not change(Post, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    it 'returns a list of posts' do
      create_list(:post, 3)
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
