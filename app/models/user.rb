class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :username, { presence: true, uniqueness: true }
  validates :email, { presence: true, uniqueness: true }
  validates :password, presence: true
  validates :password, {allow_blank: true, length: {minimum: 10}}
end
