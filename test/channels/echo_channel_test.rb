require "test_helper"

class EchoChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe
    assert subscription.confirmed?
    assert_has_stream "echo"
  end
end
