class AlbumUser < ApplicationRecord
  belongs_to :user
  belongs_to :album

  scope :owned, -> { where(owner: true) }
  scope :active, -> { joins(:user).merge(User.active) }
  scope :owned_active, -> { owned.active }

end
