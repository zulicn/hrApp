class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :department

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end