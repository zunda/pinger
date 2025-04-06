class EchoChannel < ApplicationCable::Channel
  PING_PERIOD = if Rails.env.production?
    30.seconds
  else
    5.seconds
  end

  attr_reader :uuid

  def subscribed
    @uuid = connection.connection_identifier
    stream_from @uuid
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def ping
    ActionCable.server.broadcast(@uuid, Time.now.to_f)
  end

  def pong(data)
    received_at = Time.now
    sent_at = Time.at(data["ping"])
    note = data["note"]
    logger.debug "RTT: #{"%.3f" % ((received_at - sent_at)*1000)} ms for #{note.inspect} (#{@uuid})"
  end

  periodically :ping, every: PING_PERIOD
end
