class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :department

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true


  def fullname
    fullname = ""
    fullname += firstname + " " unless firstname.blank?
    fullname += lastname unless lastname.blank?

    fullname
  end

  def is_admin?
    role.name === 'Admin'
  end

  def self.search(search)
    where("firstname LIKE ?", "%#{search}%")
  end
end