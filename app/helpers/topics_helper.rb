#encoding: utf-8
module TopicsHelper
   def format_topic_body(text,title = "",allow_image = true)
    text = simple_format(h(text))
    if allow_image
      text = text.gsub(/\[img\](http:\/\/.+?)\[\/img\]/,'<img src="\1" alt="'+ h(title) +'" />')
      # if mobile?
        # img_regexp = Regexp.new("<img\s+.*?src=[\"|']?(.*?[^\"'>]+)[\"|']?.*?>", Regexp::IGNORECASE)
        # new_text = text
        # new_text.scan(img_regexp) do |m|
          # img_url = m[0]
          # text = text.gsub(img_url, img_url.gsub("large","small"))
        # end
      # end
    end
    #text = auto_link(text,:all, :target => '_blank', :rel => "nofollow")
    return text
  end

  def topic_use_readed_text(state)
    case state
    when 0
      "在你读过以后还没有新变化"
    else
      "有新内容"
    end
  end
end
