require 'rails_helper'

RSpec.describe Post, type: :model do
    
    describe 'association' do
        specify { is_expected.to belong_to (:user) }
    end
    describe 'validation' do
        specify { is_expected.to validate_presence_of (:title) }
        specify { is_expected.to validate_presence_of (:description) }
    end
end