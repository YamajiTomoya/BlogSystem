class User < ApplicationRecord
    has_secure_password
    has_many :article, dependent: :destroy
    validates :username, {presence: true, uniqueness: true}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}
    validates :password, {presence: true, length: { minimum: 10 }}
end
