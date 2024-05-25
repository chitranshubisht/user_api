RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { create(:post) }
  let(:invalid_attributes) { { title: '' } }

  before do
    allow(JwtToken).to receive(:jwt_decode).and_return(token)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Post' do
        post :create, params: { post: valid_attributes }, session: { user: }
        expect(response.status).to eq(200)
        expect(response.body).to eq(Post.last.to_json)
      end
    end

    context 'with invalid attributes' do
      it "doesn't create a new Post" do
        post :create, params: { post: invalid_attributes }, session: { user: }
        expect(response.status).to eq(422)
        expect(response.body).to include("title can't be blank")
      end
    end
  end

  describe 'GET #index' do
    before { FactoryBot.create_list(:post, 3, user:) }

    it 'returns a list of posts' do
      get :index
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
