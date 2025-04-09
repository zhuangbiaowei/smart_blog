SmartPrompt.define_worker :generate_blog do
  use "deepseek"
  model "deepseek-chat"
  sys_msg "生成博客文章的HTML"
  prompt :generate_blog, { text: params[:text] }
  send_msg
end
