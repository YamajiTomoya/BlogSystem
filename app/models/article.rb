class Article < ApplicationRecord
    #belongs_to :user
    validates :title, {presence: true}
    validates :content, {presence: true}
    # REVIEW: boolean型はfalseを入れようとしても空で入ろうとするっぽい？
    # validates :open_flg, {presence: true}  
    validates :author, {presence: true}
end
