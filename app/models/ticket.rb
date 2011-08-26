class Ticket < ActiveRecord::Base
  belongs_to :r_table
  has_many :ticket_lines, :dependent => :destroy


end
