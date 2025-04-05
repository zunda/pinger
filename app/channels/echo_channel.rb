class EchoChannel < ApplicationCable::Channel
  PING_PERIOD = 30.seconds

  def subscribed
    stream_from "echo"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def ping
    ActionCable.server.broadcast("echo", { sent_at: Time.now.to_f })
  end

  periodically :ping, every: PING_PERIOD
end
