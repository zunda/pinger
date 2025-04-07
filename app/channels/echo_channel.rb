class EchoChannel < ApplicationCable::Channel
  attr_reader :uuid

  def subscribed
    @uuid = connection.connection_identifier
    stream_from @uuid
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def ping(data)
    ActionCable.server.broadcast(@uuid, data["ping"])
  end

  def report(data)
    sent_at = Time.at(data["sent_at"].to_f/1000)
    received_at = Time.at(data["received_at"].to_f/1000)
    note = data["note"]
    logger.debug "RTT: #{"%.0f" % ((received_at - sent_at)*1000)} ms for #{note.inspect} (#{@uuid})"
  end
end
