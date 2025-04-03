class Measurement < ApplicationRecord
  def rtt
    return received_at - sent_at
  end
end
