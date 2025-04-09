SmartAgent::Tool.define :write_blog_data do
  desc "According to the rules, write a blog metadata to posts.json"
  param_define :title, "Post Title", :string
  tool_proc do
    filename = Time.now.to_s[0..18].gsub(":", "").gsub("-", "").gsub(" ", "") + ".html"
    posts = JSON.parse(File.read("./docs/posts.json"))
    new_post = {
      "title" => input_params["title"],
      "date" => Time.now.to_s[0..18],
      "filename" => filename,
    }
    posts.unshift(new_post)
    f = File.open("./docs/posts.json", "w")
    f.puts JSON.pretty_generate(posts)
    f.close
    filename
  end
end
