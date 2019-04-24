class Comment < ApplicationRecord
    #TODO: ユーザーと記事の両方が削除されなければ削除されていない（どちらか片方が消えれば消えるようにしたい）
    belongs_to :user
    belongs_to :article
end