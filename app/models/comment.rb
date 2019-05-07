class Comment < ApplicationRecord
    #TODO: ユーザーと記事の両方が削除されなければ削除されていない（どちらか片方が消えれば消えるようにしたい）
    belongs_to :user
    belongs_to :article

    def user
        return User.find(self.user_id)
    end

    def deletable?(current_user)
        # あるコメントに対して、削除可能かどうか判定します
        return current_user.id == self.user_id || current_user.id == self.article.id
    end

    def poster?(current_user)
        # あるコメントに対して、編集可能かどうか(投稿者かどうか)を判定します
        return current_user.id == self.user_id
    end
end