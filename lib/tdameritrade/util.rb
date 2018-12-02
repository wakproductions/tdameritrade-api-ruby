module TDAmeritrade
  module Util
    module_function

    def parse_json_response(text)
      stripped_text = text.strip
      sanitized_text = stripped_text[0] == "\\" ? stripped_text[1..-1] : stripped_text
      JSON.parse(sanitized_text)
    end
  end
end