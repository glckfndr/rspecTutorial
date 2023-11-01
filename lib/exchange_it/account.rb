module ExchangeIt
  class Account
    include ExchangeIt::Utils::Uid
    attr_reader :balance, :id

    def initialize(user)
      @balance = 0
      @id = hash user.name, user.surname
    end

    def deposit(sum)
      raise 'Sum must be greater than zero' if sum <= 0

      @balance += sum
    end

    def transfer(receiver, amount)

    end

    def withdraw(amount)

    end
  end
end
