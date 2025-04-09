require "test_helper"

class MeasurementTest < ActiveSupport::TestCase
  test "parses timestamps in fixture" do
    m = measurements(:from_home)
    assert_in_delta(m.received_at, Time.new(2025, 4, 3, 2, 39, 55.3, "UTC"), 0.001)
  end

  test "parses connection id in fixture" do
    m = measurements(:from_home)
    assert m.connection.match(/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i)
  end

  test "provides round trip time" do
    assert_equal(300, measurements(:from_home).rtt_ms)
    assert_equal(5400, measurements(:in_transit).rtt_ms)
  end
end
