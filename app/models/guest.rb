class Guest < ActiveRecord::Base
  has_many :tickets
end
