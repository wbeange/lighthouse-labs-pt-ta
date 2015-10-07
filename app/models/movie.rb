class Movie < ActiveRecord::Base
  has_many :reviews
  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
