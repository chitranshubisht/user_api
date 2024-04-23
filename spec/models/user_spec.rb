require 'rails_helper'

RSpec.describe User, type: :model do
    
    describe 'association' do
        it { should have_many(:posts) }
    end
    describe 'validation' do
        it { should validate_presence_of (:name) }
        it { should validate_uniqueness_of (:name) }
        it { should validate_presence_of (:email) }
        it { should validate_uniqueness_of (:email) }
        it { should allow_value('test@example.com').for(:email) }
        it { should_not allow_value('testexample.com').for(:email) }
    end
end