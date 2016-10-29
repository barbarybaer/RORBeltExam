class User < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :alias, :email, :password, :password_confirmation, presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  
  validates :password,  length: {minimum: 8}, confirmation: true, on: :register 


  has_many :likes, through: :posts
  has_many :posts
end
