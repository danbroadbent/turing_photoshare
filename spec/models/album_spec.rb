require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should have_many(:photos) }
end
