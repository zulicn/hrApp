class User < ActiveRecord::Base
  attr_accessor  :reset_token
  belongs_to :role
  belongs_to :department
  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  has_many :memberships

  has_many :event_attendences
  has_many :events, through: :event_attendences

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  before_save   :downcase_email


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
    where("CONCAT(firstname, ' ', lastname) LIKE ?", "%#{search}%")
  end

# Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

   # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

   # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end