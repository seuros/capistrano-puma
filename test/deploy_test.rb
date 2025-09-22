require 'minitest/autorun'
require 'net/http'

Minitest.after_run do
  DeployTest.container_id && system("docker stop #{DeployTest.container_id}")
end

class DeployTest < Minitest::Test
  class << self
    attr_accessor :container_id
  end

  def self.before_suite
    system 'docker build -t capistrano-puma-test-server test'
    self.container_id = `docker run -d --privileged -p 8022:22 -p 3000:3000 capistrano-puma-test-server`
    sleep 1
  end

  before_suite

  def retry_get_response(uri, limit = 5)
    response = nil
    limit.times do
      begin
        response = Net::HTTP.get_response(URI.parse(uri))
      rescue Errno::ECONNRESET, EOFError
        sleep 1
      else
        break
      end
    end
    response
  end

  def test_deploy
    Dir.chdir('test') do
      system 'cap production puma:install'
      system 'cap production deploy'
      response = retry_get_response('http://localhost:3000')
      assert_equal '200', response.code
      system 'cap production puma:stop'
      sleep 1
      assert_raises(Errno::ECONNRESET, EOFError) do
        Net::HTTP.get_response(URI.parse('http://localhost:3000'))
      end
      system 'cap production puma:start'
      response = retry_get_response('http://localhost:3000')
      assert_equal '200', response.code
    end
  end
end
