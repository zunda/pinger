class Measurement < ApplicationRecord
  def rtt
    received_at - sent_at
  end
end
