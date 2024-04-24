# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        user_params = FactoryBot.attributes_for(:user)
        expect {
          post :create, params: { user: user_params }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user' do
        user_params = { name: '', email: '', password_digest: '' }
        expect {
          post :create, params: { user: user_params }
        }.to_not change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    it 'returns a list of users' do
      create_list(:user, 3)
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(6)
    end
  end
end
