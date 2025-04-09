SmartPrompt.define_worker :writing_bot do
  use "deepseek"
  model "deepseek-chat"
  sys_msg "生成博客文章的HTML，然后再调用write_blog工具写入文件"
  prompt :generate_blog, { text: params[:text] }
  send_msg
end
