require "test_helper"

class MeasurementTest < ActiveSupport::TestCase
  test "parses timestamps in fixture" do
    m = measurements(:from_home)
    assert_in_delta(m.sent_at, Time.new(2025,4,3,2,39,55.0,"UTC"), 0.001)
    assert_in_delta(m.received_at, Time.new(2025,4,3,2,39,55.3,"UTC"), 0.001)
  end

  test "provides round trip time" do
    assert_in_delta(0.3, measurements(:from_home).rtt, 0.001)
    assert_in_delta(5.4, measurements(:in_transit).rtt, 0.001)
  end
end
