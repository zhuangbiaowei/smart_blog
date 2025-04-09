SmartAgent.define :writer do
  result = call_worker(:blog_metadata, params, with_tools: true, with_history: true)
  if result.call_tools
    filename = call_tools(result)
    content = call_worker(:generate_blog, params, with_tools: false, with_history: true)
    f = File.new("./docs/posts/" + filename, "w")
    f.puts content
    f.close
  end
end

SmartAgent.build_agent(:writer, tools: [:write_blog_data])
