class Comment < ApplicationRecord
    belongs_to :user, :article
    validates :content, {presence: true}
    validates :user_id, {presence: true}
    validates :article_id, {presence: true}
end
