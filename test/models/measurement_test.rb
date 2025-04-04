require "test_helper"

class MeasurementTest < ActiveSupport::TestCase
  test "parses timestamps in fixture" do
    m = measurements(:from_home)
    assert_in_delta(m.sent_at, Time.new(2025,4,3,2,39,55.0,"UTC"), 0.001)
    assert_in_delta(m.received_at, Time.new(2025,4,3,2,39,55.3,"UTC"), 0.001)
  end

  test "parses connection id in fixture" do
    m = measurements(:from_home)
    assert m.connection.match(/\A[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89a-d][0-9a-f]{3}-[0-9a-f]{12}\z/i)
    # https://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_(random)
  end

  test "provides round trip time" do
    assert_in_delta(0.3, measurements(:from_home).rtt, 0.001)
    assert_in_delta(5.4, measurements(:in_transit).rtt, 0.001)
  end
end
