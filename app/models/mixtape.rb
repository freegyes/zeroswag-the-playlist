class Mixtape < ActiveRecord::Base
  has_many :contributions
  belongs_to :owner, class_name: 'User'
end
