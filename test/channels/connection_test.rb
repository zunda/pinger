require "test_helper"

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
end
