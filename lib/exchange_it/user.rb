module ExchangeIt
  class User
    attr_reader :name, :surname

    def initialize(first_name, second_name)
      raise('First or second name is nil') if first_name.nil? || second_name.nil?

      @name = first_name
      @surname = second_name
    end
  end
end
