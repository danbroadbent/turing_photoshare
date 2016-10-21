require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:album) }
end
