class Comment < ApplicationRecord
    #TODO: ユーザーと記事の両方が削除されなければ削除されていない（どちらか片方が消えれば消えるようにしたい）
    belongs_to :user
    belongs_to :article

    def deletable?(current_user)
        # あるコメントに対して、削除可能かどうか判定します
        puts current_user.id
        puts self.user_id
        puts self.article.id
        return current_user.id == self.user_id || current_user.id == self.article.id
    end
end