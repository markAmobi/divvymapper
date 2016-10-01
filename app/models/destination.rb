class Destination < ApplicationRecord
  belongs_to :origin, polymorphic: true

  
end
