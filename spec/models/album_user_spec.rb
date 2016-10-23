require 'rails_helper'

RSpec.describe AlbumUser, type: :model do
  it { should belong_to(:album) }
  it { should belong_to(:user) }
end
