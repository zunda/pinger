require "test_helper"

class ActionCable::Channel::ConnectionStub
  attr :target
  attr :source
end

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "connects with uuid" do
    connect
    assert connection.uuid.match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
  end

  test "picks up target hostname" do
    target = "pinger.example.com"
    connect headers: { "Host" => target }
    assert_equal target, connection.target
  end

  test "picks up remote addr if there is no other hints of source" do
    source = "192.0.2.1"
    connect env: { "REMOTE_ADDR" => source }
    assert_equal source, connection.source
  end
end
