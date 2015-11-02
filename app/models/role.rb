class Role < ActiveRecord::Base
  def self.admin
    @admin ||= Role.find_by(name: 'Admin')
  end

  def self.member
    @member ||= Role.find_by(name: 'Member')
  end
end