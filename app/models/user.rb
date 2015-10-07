class User < ActiveRecord::Base
  has_secure_password

  has_many :movies
  has_many :reviews

  validates :username, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, :length => { :minimum => 5, :maxiumum => 255 }
end
