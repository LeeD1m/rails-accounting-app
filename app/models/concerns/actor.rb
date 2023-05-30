# frozen_string_literal: true

module Actor
    # class Admin
    #   end
    
    #   class Employee
    #   end
    TYPES = {
      'Admin' => Admin,
      'Employee' => Employee
    }.freeze
  
    def employee?
      instance_of? TYPES['Employee']
    end
  
    def admin?
      instance_of? TYPES['Admin']
    end
  end
  