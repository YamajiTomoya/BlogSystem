class User < ApplicationRecord
    has_secure_password
    has_many :article, dependent: :destroy
    has_many :comment, dependent: :destroy

    validates :username, {presence: true, uniqueness: true}
    validates :email, {presence: true, uniqueness: true}
    validates :password, {presence: true, length: { minimum: 10 }}
end
