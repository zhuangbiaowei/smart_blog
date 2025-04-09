SmartAgent::Tool.define :search do
  desc "Calling Google Search by keywords to get results"
  param_define :q, "Search Keywords", :string
  tool_proc do
    url = URI("https://google.serper.dev/search")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["X-API-KEY"] = ENV["SERPER_API_KEY"]
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "q": input_params["q"],
    })

    response = https.request(request)
    response.read_body
  end
end
