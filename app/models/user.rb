class User < ApplicationRecord
  has_secure_password
  before_save {username.downcase!}
  validates :password, presence: true, length: {minimum: 8}, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9]).{8,}/,
                                                                       message: "Debe contener una letra minúscula, una mayúscula, un dígito del 0 al 9 y ser de más de 8 caracteres de largo. " },
            on: :create

  validates :password,
            allow_nil: true,
            length: {minimum: 8}, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9]).{8,}/,
                                            message: "Debe contener una letra minúscula, una mayúscula, un dígito del 0 al 9 y ser de más de 8 caracteres de largo. " },
            on: :update

  validates :username, presence: true, uniqueness: true

  attr_accessor :remember_token

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine::cost

    BCrypt::Password::create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def secure_password
    return false if (password =~ /[a-z]/).blank? #lower letter test
    return false if (password =~ /[A-Z]/).blank? #upper letter test
    return false if (password =~ /[0-9]/).blank? #number test
  end
end
