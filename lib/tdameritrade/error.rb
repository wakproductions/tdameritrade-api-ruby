module TDAmeritrade
  module Error
    class TDAmeritradeError < StandardError
    end

    class RateLimitError < StandardError
    end

    def self.gem_error(message)
      error = TDAmeritradeError.new(message)
      error.set_backtrace(caller)
      raise error
    end
  end
end
