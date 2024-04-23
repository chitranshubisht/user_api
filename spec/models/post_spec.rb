require 'rails_helper'

RSpec.describe Post, type: :model do
    
    describe 'association' do
        it { should belong_to (:user) }
    end
    describe 'validation' do
        it { should validate_presence_of (:title) }
        it { should validate_presence_of (:description) }
    end
end