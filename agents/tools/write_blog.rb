SmartAgent::Tool.define :write_blog do
  desc "According to the rules, write a blog post to a specific file"
  param_define :title, "Post Title", :string
  param_define :date, "Post Date", :string
  param_define :filename, "File Name", :string
  param_define :content, "Blog Content", :string
  tool_proc do
    f = File.new("./docs/posts/#{input_params["filename"]}", "w")
    f.puts input_params["content"]
    f.close
    posts = JSON.parse(File.read("./docs/posts.json"))
    new_post = {
      "title" => input_params["title"],
      "date" => input_params["date"],
      "filename" => input_params["filename"],
    }
    posts.unshift(new_post)
    f = File.open("./docs/posts.json", "w")
    f.puts JSON.pretty_generate(posts)
    f.close
  end
end
