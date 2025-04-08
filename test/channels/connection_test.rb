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
    remote_addr = "192.0.2.1"
    connect env: { "REMOTE_ADDR" => remote_addr }
    assert_equal remote_addr, connection.source
  end

  test "picks up x-forwarded-for" do
    x_forwarded_for = "192.0.2.1,192.0.2.2,192.0.0.3"
    remote_addr = "192.0.2.4"
    connect headers: { "X-Forwarded-For" => x_forwarded_for }, env: { "REMOTE_ADDR" => remote_addr }
    assert_equal x_forwarded_for, connection.source
  end
end
