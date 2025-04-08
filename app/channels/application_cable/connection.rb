module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid
    attr_reader :target
    attr_reader :source

    def connect
      self.uuid = SecureRandom.uuid
      req = self.request
      @target = req.host
      @source = req.headers["X-Forwarded-For"] || req.remote_addr
      logger.debug @source
    end
  end
end
