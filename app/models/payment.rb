class Payment < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  belongs_to :payment_method
end
