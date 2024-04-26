RSpec.describe UsersController, type: :controller do
  include JwtToken
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:invalid_attributes) { { name: '' } }
  let(:token) { encode(user.id) }

  before do
    allow(JwtToken).to receive(:jwt_decode).and_return(token)
    @user = FactoryBot.create(:user)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new User' do
        post :create, params: { user: valid_attributes }
        expect(response.status).to eq(200)
        expect(response.body).to eq(User.last.to_json)
      end
    end

    context 'with invalid attributes' do
      it "doesn't create a new User" do
        post :create, params: { user: invalid_attributes }
        expect(response.status).to eq(422)
        expect(response.body).to include("Name can't be blank")
      end
    end
  end

  describe 'GET #index' do
    before { FactoryBot.create_list(:user, 3) }

    it 'returns a list of users' do
      get :index
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns a specific user' do
      get :show, params: { id: @user.id }
      expect(response.status).to eq(200)
      expect(response.body).to eq(@user.to_json)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before { @user.update(name: 'Updated Name') }

      it 'updates the user' do
        put :update, params: { id: @user.id, user: { name: @user.name } }
        expect(response.status).to eq(200)
        expect(response.body).to be_empty
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the user" do
        put :update, params: { id: @user.id, user: { name: '' } }
        expect(response.status).to eq(503)
        expect(response.body).to include("Name can't be blank")
      end
    end
  end
end
