class User < ApplicationRecord
    validates :email, presence: true
    validates :password, presence: true, confirmation: true
    validates :email, uniqueness: true
    
    attr_accessor :password, :password_confirmation
    
    def password=(val)
        if val.present?
            self.pass = BCrypt::Password.create(val)
        end
        @password = val
    end
end
