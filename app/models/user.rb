class User < ApplicationRecord

  #tokens, bruh
  attr_accessor :remember_token, :activation_token

  #super awesome regex formatting
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  CLEAN_PHONE_REGEX = /[.!@$%^&*()a-zA-z\s$]/

  #callbacks
  before_validation { self.status ||= "news" }
  before_save { self.email.downcase! }
  before_save { if self.phone && self.phone.match(CLEAN_PHONE_REGEX) then self.phone.gsub(CLEAN_PHONE_REGEX, '') end }
  before_create :create_activation_digest

  #validation parameters
  validates :first_name, presence: true, length: { maximum: 64 }
  validates :last_name, presence: true, length: { maximum: 64 }
  validates :email, presence: true,  length: { maximum: 65 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 15 }
  validates :status, presence: true, length: { maximum: 4 }
  has_secure_password #because duuuh
  validates :password, presence: true, length: { minimum: 8 }
  
  #custom encryption parameters
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 'member? I 'member!
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # i don't wanna 'member no more!
  def forget
    update_attribute(:remember_digest, nil)
  end

  #check digests
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #prime the activation system
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
