class Order < ApplicationRecord

  #relations, far and wide
  belongs_to :customer
  belongs_to :runner
 
  #callbacks
  before_validation { self.runner_id ||= 1 }

end
