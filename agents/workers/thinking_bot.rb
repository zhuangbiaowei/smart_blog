SmartPrompt.define_worker :thinking_bot do
  use "SiliconFlow"
  model "Qwen/Qwen3-235B-A22B"
  sys_msg "你是一个聪明的智能博客助手，在与我的交谈过程中，能够给我足够多的启发，还能够根据需要调用搜索工具帮我查找更多信息。"
  prompt params[:text]
  send_msg
end
