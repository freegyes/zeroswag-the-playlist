class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :mixtape
end
