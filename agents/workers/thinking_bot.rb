SmartPrompt.define_worker :thinking_bot do
  use "SiliconFlow"
  model "Qwen/Qwen3-235B-A22B"
  sys_msg "你是一个聪明的智能博客助手，在与我的交谈过程中，能够给我足够多的启发，还能够根据需要调用搜索工具帮我查找更多信息。但是，请不必多次重复调用同一个工具，在没有更多信息的情况下，请汇总信息并给出最后的解答。"
  prompt params[:text]
  send_msg
end
