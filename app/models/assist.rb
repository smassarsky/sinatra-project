class Assist < ActiveRecord::Base
  belongs_to :player
  belongs_to :goal
end