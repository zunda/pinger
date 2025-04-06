class EchoChannel < ApplicationCable::Channel
  PING_PERIOD = if Rails.env.production?
    30.seconds
  else
    5.seconds
  end


  def subscribed
    stream_from "echo"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def ping
    ActionCable.server.broadcast("echo", Time.now.to_f)
  end

  def pong(data)
    received_at = Time.now
    sent_at = Time.at(data["message"])
    $stderr.puts "RTT: #{received_at - sent_at}"
  end

  periodically :ping, every: PING_PERIOD
end
