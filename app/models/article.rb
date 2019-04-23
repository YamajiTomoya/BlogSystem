class Article < ApplicationRecord
    belongs_to :user
    has_many :comment, dependent: :destroy
    validates :title, {presence: true}
    validates :content, {presence: true}
    # REVIEW: boolean型はfalseを入れようとしても空で入ろうとするっぽい？
    # validates :open_flg, {presence: true}  
    validates :user_id, {presence: true}
end
