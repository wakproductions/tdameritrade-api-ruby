# TODO kill this file once watchlists.rb converted to operation class

module TDAmeritrade
  module UtilResponse
    module_function

    def response_success?(response)
      response.code.to_s =~ /^2\d\d/
    end
  end
end