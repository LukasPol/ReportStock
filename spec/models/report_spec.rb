require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'associations' do
    it { should have_one_attached(:attachment) }
  end

  describe 'validations' do
    it { should validate_presence_of(:attachment) }
  end
end
