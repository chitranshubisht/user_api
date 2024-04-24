require 'rails_helper'

RSpec.describe User, type: :model do
    
    describe 'association' do
        specify { is_expected.to have_many(:posts) }
    end
    describe 'validation' do
        specify { is_expected.to validate_presence_of (:name) }
        specify { is_expected.to validate_uniqueness_of (:name) }
        specify { is_expected.to validate_presence_of (:email) }
        specify { is_expected.to validate_uniqueness_of (:email) }
        specify { is_expected.to allow_value('test@example.com').for(:email) }
        specify { is_expected.to_not allow_value('testexample.com').for(:email) }
        specify { is_expected.to validate_presence_of (:password_digest) }
    end
end