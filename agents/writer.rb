SmartAgent.define :writer do
  result = call_worker(:writing_bot, params, with_tools: true, with_history: true)
  if result.call_tools
    call_tools(result)
  end
end

SmartAgent.build_agent(:writer, tools: [:write_blog])
