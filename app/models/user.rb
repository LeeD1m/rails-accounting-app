class User < ApplicationRecord
    # has_secure_password
    belongs_to :actor, polymorphic: true, optional: true

    scope :employees, -> { where(actor_type: 'Employee') }


end
