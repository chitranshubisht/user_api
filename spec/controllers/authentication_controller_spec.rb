RSpec.describe AuthenticationController, type: :controller do
  let!(:user) { create(:user, password: 'secure_password') }

  describe '#login' do
    context 'with valid credentials' do
      it 'returns a successful response with a JWT token' do
        post :login, params: { email: user.email, password: 'secure_password' }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')

        response_body = JSON.parse(response.body)
        expect(response_body.keys).to contain_exactly('token', 'exp', 'name')
        expect(response_body['token']).to be_a(String)
        expect(response_body['exp']).to be_a(String)
        expect(response_body['name']).to eq(user.name)
      end

      it 'encodes the JWT token with user ID' do
        post :login, params: { email: user.email, password: 'secure_password' }

        response_body = JSON.parse(response.body)
        decoded_token = JWT.decode(response_body['token'], Rails.application.secrets.secret_key_base)[0]
        expect(decoded_token['user_id']).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized response' do
        post :login, params: { email: user.email, password: 'wrong_password' }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq({ error: 'unauthorized' }.to_json)
      end
    end

    context 'with missing email' do
      it 'returns an unprocessable entity response' do
        post :login, params: { password: 'secure_password' }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with missing password' do
      it 'returns an unprocessable entity response' do
        post :login, params: { email: user.email }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
