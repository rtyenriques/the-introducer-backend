class User < ApplicationRecord
    #creates an authenticate method
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
end
