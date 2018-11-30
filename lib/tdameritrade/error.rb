module TDAmeritrade
  module Error
    class TDAmeritradeError < StandardError
    end

    def gem_error(message)
      error = TDAmeritradeError.new(message)
      error.set_backtrace(caller)
      raise error
    end
  end
end
