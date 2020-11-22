class PlayerCode < ActiveRecord::Base
  belongs_to :player

  validates :player, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :status, presence: true
end

