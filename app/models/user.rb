class User < ApplicationRecord

  attr_accessor :remember_token

  #callbacks
  before_validation { self.status ||= "news" }
  before_save { self.email.downcase! }
  before_save { if self.phone && self.phone.match(/[.!@$%^&*()a-zA-z\s]/) then self.phone.gsub(/[.!@$%^&*()a-zA-z\s]/, '') end }

  #super awesome regex formatting
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  #validation parameters
  validates :first_name, presence: true, length: { maximum: 64 }
  validates :last_name, presence: true, length: { maximum: 64 }
  validates :email, presence: true,  length: { maximum: 65 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 15 }
  validates :adr_street, presence: true, length: { maximum: 65 } 
  validates :adr_city, presence: true, length: { maximum: 65 }
  validates :adr_state, presence: true, length: { maximum: 2 }
  validates :adr_zip, presence: true, length: { minimum: 5, maximum: 15 }
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

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  # i don't 'member no more!
  def forget
    update_attribute(:remember_digest, nil)
  end

end
