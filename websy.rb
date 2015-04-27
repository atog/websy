require 'camping'
require 'rack'

Camping.goes :Websy

module Websy::Controllers

  class Static < R '/(.*)'
    PATH = File.expand_path(File.dirname(__FILE__))
    def get(path)
      if !path || path.strip == ""
        serve "index.html", File.read("#{PATH}/public/index.html")
      elsif !path.include? ".." # prevent directory traversal attacks
        serve "#{path}", File.read("#{PATH}/public/#{path}")
      else
        @status = "403"
        "403 - Invalid path"
      end
    rescue
      @status = "403"
      "403 - Invalid path"
    end
  end
end
