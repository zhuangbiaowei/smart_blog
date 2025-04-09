SmartPrompt.define_worker :blog_metadata do
  use "deepseek"
  model "deepseek-chat"
  sys_msg "获取博客文章标题"
  prompt "基于对话历史，生成博客的文章标题"
  send_msg
end
