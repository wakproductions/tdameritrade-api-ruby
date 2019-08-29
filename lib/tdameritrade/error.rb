module TDAmeritrade
  module Error
    module_function

    class TDAmeritradeError < StandardError
    end

    class RateLimitError < StandardError
    end

    class NotAuthorizedError < StandardError
    end

    def gem_error(message)
      error = TDAmeritradeError.new(message)
      error.set_backtrace(caller)
      raise error
    end
  end
end
