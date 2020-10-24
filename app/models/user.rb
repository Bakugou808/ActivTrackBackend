class User < ApplicationRecord
    has_secure_password
    validates_presence_of :username, :email
    validates_uniqueness_of :email, :username
    has_many :folders, dependent: :destroy
    has_many :workouts, through: :folders

    # after_create :create_folder

    
end
