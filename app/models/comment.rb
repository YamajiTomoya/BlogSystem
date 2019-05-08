class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :article

    validates :content, {presence: true}

    def user
        return User.find(self.user_id)
    end

    def deletable?(current_user)
        # あるコメントに対して、削除可能かどうか判定します
        unless current_user
            return false
        end
        return current_user.id == self.user_id || current_user.id == self.article.user_id
    end

    def poster?(current_user)
        # あるコメントに対して、編集可能かどうか(投稿者かどうか)を判定します
        unless current_user
            return false
        end
        return current_user.id == self.user_id
    end
end