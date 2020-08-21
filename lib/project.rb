require_relative "./project/fetch/fetch.rb"

module Project
  Fetch.new
  class Error < StandardError
  end
end
