#encoding: utf-8
module ApplicationHelper
   # return the formatted flash[:notice] html
  def notice_message
    if flash[:notice]
      result = '<div id="success_message">' + flash[:notice] + '</div>'
    else
      result = ''
    end

   raw(result)
  end

end
