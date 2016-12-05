class User < ApplicationRecord

  #callbacks
  before_validation { self.status ||= "news" }
  before_save { self.email.downcase! }
  before_save { self.phone.gsub(/\D/, '')}
  
  #validation parameters
  validates :first_name, presence: true, length: { maximum: 64 }
  validates :last_name, presence: true, length: { maximum: 64 }
  #super awesome regex formatting
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,  length: { maximum: 65 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 15 }
  validates :adr_street, presence: true, length: { maximum: 65 } 
  validates :adr_city, presence: true, length: { maximum: 65 }
  validates :adr_state, presence: true, length: { maximum: 2 }
  validates :adr_zip, presence: true, length: { minimum: 5, maximum: 15 }
  validates :status, presence: true, length: { maximum: 4 }
  #because duuuh
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
  #sloppy encryption for test suite
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
