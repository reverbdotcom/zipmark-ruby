require 'jwt'

module Zipmark
  class Token
    def self.encode(payload)
      ::JWT.encode(payload, nil, 'none')
    end
  end
end
