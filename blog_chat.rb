require "readline"
require "uri"
require "json"
require "net/http"
require "../smart_prompt/lib/smart_prompt"
require "../smart_agent/lib/smart_agent"

class LLMInteraction
  def initialize(engine)
    @engine = engine
    @current_agent = @engine.agents[:smart_blog]
  end

  def start
    puts "欢迎使用博客助手!"
    puts "您可以输入内容来调用不同的智能代理,或者输入 /agent_name 来切换智能代理。"
    puts "输入 'exit' 来退出程序。"

    loop do
      input = Readline.readline("> ", true)
      break if input.nil?

      case input
      when "exit"
        puts "感谢使用,再见!"
        break
      when "list"
        puts @engine.agents.keys
      when /^\/(\w+)/
        change_agent($1)
      else
        unless input.empty?
          call_agent(input)
        end
      end
    end
  end

  private

  def change_agent(agent_name)
    if @engine.agents[agent_name.to_sym]
      @current_agent = @engine.agents[agent_name.to_sym]
      puts "已切换到智能代理: #{agent_name}"
    else
      puts "智能代理 #{agent_name} 不存在。"
    end
  end

  def call_agent(input)
    @current_agent.on_reasoning do |reasoning_content|
      print reasoning_content.dig("choices", 0, "delta", "reasoning_content")
      print "\n" if reasoning_content.dig("choices", 0, "finish_reason") == "stop"
    end

    @current_agent.on_content do |content|
      print content.dig("choices", 0, "delta", "content")
      print "\n" if content.dig("choices", 0, "finish_reason") == "stop"
    end

    @current_agent.on_tool_call do |msg|
      puts msg
    end

    @current_agent.please(input)
  end
end

engine = SmartAgent::Engine.new("./config/agent.yml")
LLMInteraction.new(engine).start
