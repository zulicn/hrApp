class User < ActiveRecord::Base
  belongs_to :role
  belongs_to :department

  def fullname
    fullname = ""
    fullname += firstname + " " unless firstname.blank?
    fullname += lastname unless lastname.blank?

    fullname
  end

  def is_admin?
  	role.name === 'Admin'
  end
end