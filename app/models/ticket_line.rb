class TicketLine < ActiveRecord::Base
  belongs_to :product
  belongs_to :ticket
end
