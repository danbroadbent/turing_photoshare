require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:albums) }
  it { should have_many(:photos) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
end
