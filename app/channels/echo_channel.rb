class EchoChannel < ApplicationCable::Channel
  attr_reader :uuid

  def subscribed
    @uuid = connection.connection_identifier
    stream_from @uuid
    @target = connection.target
    @source = connection.source
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def ping(data)
    ActionCable.server.broadcast(@uuid, data["ping"])
  end

  def report(data)
    rtt_ms = data["received_at"] - data["sent_at"]
    received_at = Time.at(Rational(data["received_at"], 1000))
    note = data["note"]
    Measurement.create(
      connection: @uuid,
      note: note,
      source: @source,
      target: @target,
      rtt_ms: rtt_ms,
      received_at: received_at,
    )
    logger.info "RTT from #{@source} to #{@target}: #{rtt_ms} ms for #{note.inspect} (#{@uuid})"
  end
end
