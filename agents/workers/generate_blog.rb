SmartPrompt.define_worker :generate_blog do
  use "deepseek"
  model "deepseek-chat"
  sys_msg "基于对话历史，不要遗漏内容，生成一篇完整丰富的博客文章的HTML"
  prompt :generate_blog, { text: params[:text] }
  send_msg
end
