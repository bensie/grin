require 'rest_client'
require 'json'
require File.expand_path(File.dirname(__FILE__) + '/grin/client')
require File.expand_path(File.dirname(__FILE__) + '/grin/album')
require File.expand_path(File.dirname(__FILE__) + '/grin/photo')
require File.expand_path(File.dirname(__FILE__) + '/grin/category')

module Grin
  class AccessDenied < StandardError; end
end