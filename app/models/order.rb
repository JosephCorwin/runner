class Order < ApplicationRecord

  #relations, far and wide
  belongs_to :customer
  belongs_to :runner

end
