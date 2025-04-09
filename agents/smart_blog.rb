SmartAgent.define :smart_blog do
  call_tool = true
  while call_tool
    result = call_worker(:thinking_bot, params, with_tools: true, with_history: true)
    if result.call_tools
      call_tools(result)
    else
      call_tool = false
    end
  end
  if result != true
    result.response
  else
    result
  end
end

SmartAgent.build_agent(:smart_blog, tools: [:search])
