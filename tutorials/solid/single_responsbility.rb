# A class should only have a single responsbility

# a class should only have one reason to change

require 'net/http'
require 'json'

class BlogService
  # can break this to environment set up
  def initialize(environment = 'development')
    @env = environment
  end


  def posts
    # configuration
    url = 'https://jsonplaceholder.typicode.com/posts'
    url = 'https://prod.myserver.com' if env == 'production'

    # puts this into logging utility
    puts "[BlogService] GET #{url}"

    # http layer
    response = Net::HTTP.get_response(URI(url))

    return [] if response.code != '200'

    # parsing response
    posts = JSON.parse(response.body)
    posts.map do |params|
      Post.new(
        id: params['id'],
        user_id: params['userId'],
        body: params['body'],
        title: params['title']
      )
    end
  end

  private

  attr_reader :env
end

class Post
  attr_reader :id, :user_id, :body, :title

  def initialize(id:, user_id:, body:, title:)
    @id = id
    @user_id = user_id
    @body = body
    @title = title
  end
end


class BlogService
  include RequestLogger

  def initialize(env)
    @env = env
  end

  def posts
    url = "#{config.base_url}/posts"
    log_request("BlogService", "GET", url)

    response = Net::HTTP.get_response(URI(url))
    posts = request_handler.send_request(url)
    response_processor.process(posts, Post, mapping)

  private

  def config
    @config ||= BlogServiceConfiguration.new(env: @env)
  end

  def request_handler
    @request_handler ||= RequestHandler.new
  end

  def response_processor
    @repsonse_processor ||= ResponseProcessor.new
  end

  def mapping
    { 'id' => :id, 'userId' => :user_id, 'body' => :body, 'title' => :title }
  end
end

class RequestHandler
  ResponseError = Class.new(StandardError)

  def send_request(url, method = :get)
    response = Net::HTTP.get_response(URI(url))
    raise ResponseError if response.code != '200'

    JSON.parse(response.body)
  end
end

class ResponseProcessor
  def process(response, entity)
    return entity.new(response) if response.is_a?(Hash)

    if response.is_a?(Array)
      response.map { |h| entity.new(h) if h.is_a?(Hash) }
    end
  end

end

class BlogServiceConfiguration
  def initialize(env)
    @env = env
  end

  def base_url
    return 'https://prod.myserver.com' if @env == 'production'

    'https://jsonplaceholder.typicode.com'
end

module RequestLogger
  def log_request(service, method = 'GET', url)
    puts "#{service}- #{method} #{url}"
  end
end

blog_service = BlogService.new
puts blog_service.posts
