module UserStatisticsHelper
  # 存在する統計情報のみ表示
  def display_data(user_statistic)
    return '作成中...' if user_statistic.making?

    # attributesのkeyをわざわざSymbolにしないためにこの記法を使っている
    convert_to_legend = {
      'article_count' => '記事数',
      'comment_count' => 'コメント数'
    }

    ret_str = ''
    user_statistic.attributes.each do |key, value|
      next if value.nil? || !key.in?(convert_to_legend)

      ret_str += "#{convert_to_legend[key]}: #{value} &nbsp;"
    end
    ret_str.html_safe
  end
end
