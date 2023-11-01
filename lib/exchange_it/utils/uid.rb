require 'digest'
module ExchangeIt
  module Utils
    module Uid
      def hash(*args)
        return nil if args.any?

        Digest::MD5.hexdigest args.join(' ')
      end
    end
  end
end
