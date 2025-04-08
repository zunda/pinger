module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid
    attr_reader :target

    def connect
      self.uuid = SecureRandom.uuid
      req = self.request
      @target = req.host
    end
  end
end
