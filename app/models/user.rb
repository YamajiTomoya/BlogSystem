class User < ApplicationRecord
  has_secure_password
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, { presence: true, uniqueness: true }
  validates :email, { presence: true, uniqueness: true }
  validates :password, { allow_blank: true, presence: true, length: { minimum: 10 } }
end
