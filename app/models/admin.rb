class Admin < ApplicationRecord
    has_one :users, as: :actor
    include Actor
end
