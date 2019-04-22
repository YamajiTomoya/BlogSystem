class Article < ApplicationRecord
    belongs_to :user
    validates :title, {presence: true}
    validates :content, {presence: true}
    validates :open_flg, {presence: true}
    validates :author, {presence: true}
end
